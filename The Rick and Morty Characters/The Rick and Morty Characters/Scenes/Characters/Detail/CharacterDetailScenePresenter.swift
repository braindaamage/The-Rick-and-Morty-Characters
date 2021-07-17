//
//  CharacterDetailScenePresenter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

protocol CharacterDetailPresentationLogic {
    func presentCharacterDetail(response: CharacterDetailSceneModels.Detail.Response)
}

class CharacterDetailScenePresenter: CharacterDetailPresentationLogic {
    weak var viewController: CharacterDetailSceneDisplayLogic?
    
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
        viewController?.displayDetail(viewModel: viewModel)
    }
}
