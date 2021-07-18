//
//  CharacterDetailSceneInteractorTests.swift
//  The Rick and Morty Characters Tests
//
//  Created by Leonardo Olivares on 17-07-21.
//

@testable import The_Rick_and_Morty_Characters
import XCTest

class CharacterDetailSceneInteractorTests: XCTestCase {
    
    func testFetchCharacterData() throws {
        let character = RickAndMortyCharacter(id: 1,
                                              name: "Nombres",
                                              status: .Alive,
                                              species: "Specie",
                                              type: "Type",
                                              gender: .Genderless,
                                              origin: RickAndMortyCharacter.Origin(name: "Origin"),
                                              location: RickAndMortyCharacter.Location(name: "Location"),
                                              image: "path/to/image")
        
        class PresenterClassMock: CharacterDetailPresentationLogic {
            var character: RickAndMortyCharacter?
            func presentCharacterDetail(response: CharacterDetailSceneModels.Detail.Response) {
                self.character = response.character
            }
        }
        
        let presenterMock = PresenterClassMock()
        let interactor = CharacterDetailSceneInteractor(character: character,
                                                        presenter: presenterMock)
        
        let request = CharacterDetailSceneModels.Detail.Request()
        interactor.fetchCharacterData(request: request)
        
        XCTAssertNotNil(presenterMock.character)
        XCTAssertEqual(character.id, presenterMock.character?.id)
    }
}
