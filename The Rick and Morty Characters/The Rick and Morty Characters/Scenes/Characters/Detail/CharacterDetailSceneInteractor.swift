//
//  CharacterDetailSceneInteractor.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import Foundation

protocol CharacterDetailSceneInteractorInput {
    func fetchCharacterData(request: CharacterDetailSceneModels.Detail.Request)
}

protocol CharacterDetailSceneInteractorOutput {
    func presentCharacterDetail(response: CharacterDetailSceneModels.Detail.Response)
}

protocol CharacterDetailDataStore
{
    var character: RickAndMortyCharacter? { get set }
}

final public class CharacterDetailSceneInteractor: CharacterDetailSceneInteractorInput,
                                                   CharacterDetailDataStore {
    
    var character: RickAndMortyCharacter?
    var output: CharacterDetailSceneInteractorOutput!
    
    init(character: RickAndMortyCharacter? = nil,
         output: CharacterDetailSceneInteractorOutput? = nil) {
        self.character = character
        self.output = output
    }
    
    func fetchCharacterData(request: CharacterDetailSceneModels.Detail.Request) {
        guard let character = character else { return }
        
        let response = CharacterDetailSceneModels.Detail.Response(character: character)
        output.presentCharacterDetail(response: response)
    }
}
