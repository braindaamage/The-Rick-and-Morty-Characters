//
//  CharacterDetailScenePresenter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

protocol CharacterDetailScenePresenterInput {
    func presentCharacterDetail(response: CharacterDetailSceneModels.Detail.Response)
}

protocol CharacterDetailScenePresenterOutput: AnyObject {
    func displayDetail(viewModel: CharacterDetailSceneModels.Detail.ViewModel)
}

public final class CharacterDetailScenePresenter: CharacterDetailScenePresenterInput {
    weak var output: CharacterDetailScenePresenterOutput!
    
    init(output: CharacterDetailScenePresenterOutput? = nil) {
        self.output = output
    }
    
    func presentCharacterDetail(response: CharacterDetailSceneModels.Detail.Response) {
        let viewModel = CharacterDetailSceneModels.Detail.ViewModel(id: response.character.id,
                                                                    name: response.character.name,
                                                                    image: response.character.image,
                                                                    status: response.character.status.rawValue,
                                                                    species: response.character.species,
                                                                    type: response.character.type,
                                                                    gender: response.character.gender.rawValue,
                                                                    origin: response.character.origin.name,
                                                                    location: response.character.location.name)
        output.displayDetail(viewModel: viewModel)
    }
}
