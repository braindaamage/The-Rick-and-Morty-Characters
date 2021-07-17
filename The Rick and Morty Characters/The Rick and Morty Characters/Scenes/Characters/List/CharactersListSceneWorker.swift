//
//  CharactersListSceneWorker.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import Foundation

protocol CharacterListServiceProtocol {
    func fetchCharactersList(request: CharactersListServiceModel.List.Request, completion: @escaping (Result<RickAndMortyAPI.Characters.List, Error>) -> Void)
    func fetchCharacter(request: CharactersListServiceModel.Character.Request, completion: @escaping (Result<RickAndMortyCharacter, Error>) -> Void)
}

class CharacterListSceneWorker: CharacterListServiceProtocol {
    var apiService: RickAndMostyAPIProtocol?
    
    init(apiService: RickAndMostyAPIProtocol) {
        self.apiService = apiService
    }
    
    func fetchCharactersList(request: CharactersListServiceModel.List.Request, completion: @escaping (Result<RickAndMortyAPI.Characters.List, Error>) -> Void) {
        apiService?.getCharactersByPage(request.page, completion: { result in
            switch result {
            case .success(let list):
                completion(.success(list))
                break
            case.failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchCharacter(request: CharactersListServiceModel.Character.Request, completion: @escaping (Result<RickAndMortyCharacter, Error>) -> Void) {
        apiService?.getCharacterById(request.id, completion: { result in
            switch result {
            case .success(let character):
                completion(.success(character))
                break
            case.failure(let error):
                completion(.failure(error))
            }
        })
    }
}
