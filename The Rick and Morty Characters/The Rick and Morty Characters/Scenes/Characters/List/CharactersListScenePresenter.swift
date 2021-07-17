//
//  CharactersListScenePresenter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

protocol CharactersListPresentationLogic {
    func presentCharactersList(response: CharactersListSceneModel.List.Response)
    func presentCharacterDetail(response: CharactersListSceneModel.Detail.Response)
}

class CharactersListScenePresenter: CharactersListPresentationLogic {
    weak var viewController: CharactersListSceneDisplayLogic?
    
    func presentCharactersList(response: CharactersListSceneModel.List.Response) {
        var displayedCharactersList: [CharactersListSceneModel.DisplayedCharacter] = []
        for character in response.list {
            let displayedCharacter = CharactersListSceneModel.DisplayedCharacter(id: character.id,
                                                                                 name: character.name,
                                                                                 image: character.image)
            
            displayedCharactersList.append(displayedCharacter)
        }
        
        let viewModel = CharactersListSceneModel.List.ViewModel(list: displayedCharactersList,
                                                                pages: response.pages)
        viewController?.displayList(viewModel: viewModel)
    }
    
    func presentCharacterDetail(response: CharactersListSceneModel.Detail.Response) {
        let viewModel = CharactersListSceneModel.Detail.ViewModel()
        viewController?.displayDetail(viewModel: viewModel)
    }
}
