//
//  CharactersListScenePresenter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

protocol CharactersListScenePresenterInput {
    func presentCharactersList(response: CharactersListSceneModel.List.Response)
    func presentCharacterDetail(response: CharactersListSceneModel.Detail.Response)
}

protocol CharactersListScenePresenterOutput: AnyObject {
    func displayList(viewModel: CharactersListSceneModel.List.ViewModel)
    func displayDetail(viewModel: CharactersListSceneModel.Detail.ViewModel)
}

public final class CharactersListScenePresenter: CharactersListScenePresenterInput {
    weak var output: CharactersListScenePresenterOutput!
    
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
        output.displayList(viewModel: viewModel)
    }
    
    func presentCharacterDetail(response: CharactersListSceneModel.Detail.Response) {
        let viewModel = CharactersListSceneModel.Detail.ViewModel()
        output.displayDetail(viewModel: viewModel)
    }
}
