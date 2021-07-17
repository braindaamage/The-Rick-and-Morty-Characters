//
//  CharactersListSceneInteractor.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import Foundation

protocol CharactersListBusinessLogic {
    func fetchCharactersList(request: CharactersListSceneModel.List.Request)
    func prepareCharacterDetail(request: CharactersListSceneModel.Detail.Request)
}

protocol CharactersListDataStore
{
    var character: RickAndMortyCharacter? { get set }
}

class CharactersListSceneInteractor: CharactersListBusinessLogic, CharactersListDataStore {
    
    var character: RickAndMortyCharacter?
    var charactersList: [RickAndMortyCharacter] = []
    var presenter: CharactersListPresentationLogic?
    private let charactersListWorker: CharacterListServiceProtocol = CharacterListSceneWorker(apiService: RickAndMortyAPICaller())
    
    func fetchCharactersList(request: CharactersListSceneModel.List.Request) {
        let apiRequest = CharactersListServiceModel.List.Request(page: request.page)
        charactersListWorker.fetchCharactersList(request: apiRequest) { [weak self] result in
            switch result {
            case .success(let workerResponse):
                if apiRequest.page == 1 {
                    self?.charactersList = workerResponse.results
                } else {
                    self?.charactersList.append(contentsOf: workerResponse.results)
                }
                
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
    
    func prepareCharacterDetail(request: CharactersListSceneModel.Detail.Request) {
        guard let character = charactersList.first(where: { $0.id == request.characterId }) else { return }
        self.character = character
        
        let response = CharactersListSceneModel.Detail.Response()
        presenter?.presentCharacterDetail(response: response)
    }
}
