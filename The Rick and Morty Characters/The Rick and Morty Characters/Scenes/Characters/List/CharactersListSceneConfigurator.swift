//
//  CharactersListSceneConfigurator.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 18-07-21.
//

import Foundation

// MARK: Connect View, Interactor, and Presenter

extension CharactersListSceneViewController: CharactersListScenePresenterOutput { }
extension CharactersListSceneInteractor: CharactersListSceneViewControllerOutput { }
extension CharactersListScenePresenter: CharactersListSceneInteractorOutput { }

class CharactersListSceneConfigurator {
    // MARK: Object lifecycle
     
    static let sharedInstance: CharactersListSceneConfigurator = {
        CharactersListSceneConfigurator()
    }()

    // MARK: Configuration

    func configure(viewController: CharactersListSceneViewController) {
        let presenter = CharactersListScenePresenter()
        presenter.output = viewController

        let interactor = CharactersListSceneInteractor()
        interactor.output = presenter

        let router = CharactersListSceneRouter()
        router.viewController = viewController
        router.dataStore = interactor

        viewController.output = interactor
        viewController.router = router
    }
}
