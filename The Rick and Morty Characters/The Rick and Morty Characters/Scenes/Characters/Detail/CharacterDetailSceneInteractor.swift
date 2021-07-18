//
//  CharacterDetailSceneInteractor.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import Foundation

protocol CharacterDetailBusinessLogic {
    func fetchCharacterData(request: CharacterDetailSceneModels.Detail.Request)
}

protocol CharacterDetailDataStore
{
    var character: RickAndMortyCharacter? { get set }
}

class CharacterDetailSceneInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    
    var character: RickAndMortyCharacter?
    var presenter: CharacterDetailPresentationLogic?
    
    init(character: RickAndMortyCharacter? = nil, presenter: CharacterDetailPresentationLogic? = nil) {
        self.character = character
        self.presenter = presenter
    }
    
    func fetchCharacterData(request: CharacterDetailSceneModels.Detail.Request) {
        guard let character = character else { return }
        
        let response = CharacterDetailSceneModels.Detail.Response(character: character)
        presenter?.presentCharacterDetail(response: response)
    }
}
