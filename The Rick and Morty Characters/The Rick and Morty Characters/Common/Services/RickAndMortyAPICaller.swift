//
//  APICaller.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import Foundation

protocol RickAndMostyAPIProtocol {
    func getCharactersByPage(_ page: Int, completion: @escaping (Result<RickAndMortyAPI.Characters.List, Error>) -> Void)
}

final public class RickAndMortyAPICaller: RickAndMostyAPIProtocol {
    
    private let session: URLSession!
    
    init(withSession session: URLSession = .shared) {
        self.session = session
    }
    
    struct Constant {
        static let baseAPIURL = "https://rickandmortyapi.com/api/character"
    }
    
    enum APIError: Error {
        case failedToGetData
        case invalidUrl
    }
    
    func getCharactersByPage(_ page: Int, completion: @escaping (Result<RickAndMortyAPI.Characters.List, Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseAPIURL)/?page=\(page)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        createRequest(with: url,
                      type: .GET) { [weak self] baseRequest in
            self?.session.dataTask(with: baseRequest) { data, _, error in
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
            }.resume()
        }
    }
    
    // MARK: - Private
    
    private enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
}
