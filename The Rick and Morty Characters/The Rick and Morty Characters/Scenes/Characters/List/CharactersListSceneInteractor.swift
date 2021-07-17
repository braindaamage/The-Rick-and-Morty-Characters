//
//  CharactersListSceneInteractor.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import Foundation

protocol CharactersListBusinessLogic {
    func fetchCharactersList(request: CharactersListSceneModel.List.Request)
}

class CharactersListSceneInteractor: CharactersListBusinessLogic {
    
    var presenter: CharactersListPresentationLogic?
    private let charactersListWorker: CharacterListServiceProtocol = CharacterListSceneWorker(apiService: RickAndMortyAPICaller())
    
    func fetchCharactersList(request: CharactersListSceneModel.List.Request) {
        let apiRequest = CharactersListServiceModel.List.Request(page: request.page)
        charactersListWorker.fetchCharactersList(request: apiRequest) { [weak self] result in
            switch result {
            case .success(let workerResponse):
                DispatchQueue.main.async {
                    let response = CharactersListSceneModel.List.Response(list: workerResponse.results,
                                                                          pages: workerResponse.info.pages)
                    self?.presenter?.presentCharactersList(response: response)
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
