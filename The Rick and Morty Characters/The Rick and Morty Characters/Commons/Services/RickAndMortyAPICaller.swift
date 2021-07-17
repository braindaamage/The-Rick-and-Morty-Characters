//
//  APICaller.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import Foundation

protocol RickAndMostyAPIProtocol {
    func getCharactersByPage(_ page: Int, completion: @escaping (Result<RickAndMortyAPI.Characters.List, Error>) -> Void)
    func getCharacterById(_ id: Int, completion: @escaping (Result<RickAndMortyCharacter, Error>) -> Void)
}

final class RickAndMortyAPICaller: RickAndMostyAPIProtocol {
    
    struct Constant {
        static let baseAPIURL = "https://rickandmortyapi.com/api/character"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getCharactersByPage(_ page: Int, completion: @escaping (Result<RickAndMortyAPI.Characters.List, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constant.baseAPIURL)/?page=\(page)"),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RickAndMortyAPI.Characters.List.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCharacterById(_ id: Int, completion: @escaping (Result<RickAndMortyCharacter, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constant.baseAPIURL)/\(id)"),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RickAndMortyCharacter.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Private
    
    private enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        guard let apiUrl = url else {
            return
        }
        var request = URLRequest(url: apiUrl)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
}