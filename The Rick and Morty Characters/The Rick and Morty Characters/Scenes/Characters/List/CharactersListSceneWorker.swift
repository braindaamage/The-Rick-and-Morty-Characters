//
//  CharactersListSceneWorker.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import Foundation

protocol CharacterListServiceProtocol {
    func fetchCharactersList(request: CharactersListServiceModel.List.Request,
                             completion: @escaping (Result<RickAndMortyAPI.Characters.List, Error>) -> Void)
}

public final class CharacterListSceneWorker: CharacterListServiceProtocol {
    private var apiService: RickAndMostyAPIProtocol?
    
    init(apiService: RickAndMostyAPIProtocol) {
        self.apiService = apiService
    }
    
    func fetchCharactersList(request: CharactersListServiceModel.List.Request,
                             completion: @escaping (Result<RickAndMortyAPI.Characters.List, Error>) -> Void) {
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
}
