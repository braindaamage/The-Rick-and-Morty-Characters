//
//  CharacterDetailSceneConfigurator.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 18-07-21.
//

import Foundation

// MARK: Connect View, Interactor, and Presenter

extension CharacterDetailSceneViewController: CharacterDetailScenePresenterOutput { }
extension CharacterDetailSceneInteractor: CharacterDetailSceneViewControllerOutput { }
extension CharacterDetailScenePresenter: CharacterDetailSceneInteractorOutput { }

final public class CharacterDetailSceneConfigurator {
    // MARK: Object lifecycle
     
    public static let sharedInstance: CharacterDetailSceneConfigurator = CharacterDetailSceneConfigurator()
    
    private init() { }

    // MARK: Configuration

    func configure(viewController: CharacterDetailSceneViewController) {
        let presenter = CharacterDetailScenePresenter()
        presenter.output = viewController

        let interactor = CharacterDetailSceneInteractor()
        interactor.output = presenter

        let router = CharacterDetailSceneRouter()
        router.viewController = viewController
        router.dataStore = interactor

        viewController.output = interactor
        viewController.router = router
    }
}
