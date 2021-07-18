//
//  CharactersListSceneInteractor.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import Foundation

protocol CharactersListSceneInteractorInput {
    func fetchCharactersList(request: CharactersListSceneModel.List.Request)
    func prepareCharacterDetail(request: CharactersListSceneModel.Detail.Request)
}

protocol CharactersListSceneInteractorOutput {
    func presentCharactersList(response: CharactersListSceneModel.List.Response)
    func presentCharacterDetail(response: CharactersListSceneModel.Detail.Response)
}

protocol CharactersListDataStore
{
    var character: RickAndMortyCharacter? { get set }
}

class CharactersListSceneInteractor: CharactersListSceneInteractorInput, CharactersListDataStore {
    
    var character: RickAndMortyCharacter?
    var charactersList: [RickAndMortyCharacter] = []
    var output: CharactersListSceneInteractorOutput!
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
                    self?.output.presentCharactersList(response: response)
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
        output.presentCharacterDetail(response: response)
    }
}
