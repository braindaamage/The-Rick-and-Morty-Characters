//
//  CharactersListSceneInteractor.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import Foundation

protocol CharactersListBusinessLogic {
    func fetchNextCharactersPage(request: CharactersListSceneModel.List.Request)
    func fetchCharacter(request: CharactersListSceneModel.Character.Request)
}

class CharactersListSceneInteractor: CharactersListBusinessLogic {
    private var currentPage = 1
    private let charactersListWorker: CharacterListServiceProtocol = CharacterListSceneWorker(apiService: RickAndMortyAPICaller())
    
    func fetchNextCharactersPage(request: CharactersListSceneModel.List.Request) {
        let apiRequest = CharactersListServiceModel.List.Request(page: currentPage)
        charactersListWorker.fetchCharactersList(request: apiRequest) { result in
            switch result {
            case .success(let list):
                print(list)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCharacter(request: CharactersListSceneModel.Character.Request) {
        let apiRequest = CharactersListServiceModel.Character.Request(id: request.id)
        charactersListWorker.fetchCharacter(request: apiRequest) { result in
            switch result {
            case .success(let character):
                print(character)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
