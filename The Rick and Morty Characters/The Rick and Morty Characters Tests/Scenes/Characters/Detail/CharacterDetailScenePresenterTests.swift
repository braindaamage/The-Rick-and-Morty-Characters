//
//  CharacterDetailScenePresenterTests.swift
//  The Rick and Morty Characters Tests
//
//  Created by Leonardo Olivares on 17-07-21.
//

@testable import The_Rick_and_Morty_Characters
import XCTest

class CharacterDetailScenePresenterTests: XCTestCase {
    
    func testPresentCharacterDetail() throws {
        let character = RickAndMortyCharacter(id: 1,
                                              name: "Nombres",
                                              status: .Alive,
                                              species: "Specie",
                                              type: "Type",
                                              gender: .Genderless,
                                              origin: RickAndMortyCharacter.Origin(name: "Origin"),
                                              location: RickAndMortyCharacter.Location(name: "Location"),
                                              image: "path/to/image")
        
        class CharacterDetailScenePresenterOutputMock: CharacterDetailScenePresenterOutput {
            var viewModel: CharacterDetailSceneModels.Detail.ViewModel?
            func displayDetail(viewModel: CharacterDetailSceneModels.Detail.ViewModel) {
                self.viewModel = viewModel
            }
        }
        
        let outputMock = CharacterDetailScenePresenterOutputMock()
        let presenter = CharacterDetailScenePresenter(output: outputMock)
        
        let response = CharacterDetailSceneModels.Detail.Response(character: character)
        presenter.presentCharacterDetail(response: response)
        
        XCTAssertNotNil(outputMock.viewModel)
        XCTAssertEqual(character.id, outputMock.viewModel?.id)
    }
}
