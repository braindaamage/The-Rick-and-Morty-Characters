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

final public class CharactersListSceneConfigurator {
    // MARK: Object lifecycle
     
    public static let sharedInstance: CharactersListSceneConfigurator = CharactersListSceneConfigurator()
    
    private init() { }

    // MARK: Configuration

    public func configure(viewController: CharactersListSceneViewController) {
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
