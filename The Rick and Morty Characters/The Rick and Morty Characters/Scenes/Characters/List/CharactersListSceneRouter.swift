//
//  CharactersListSceneRouter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

@objc protocol CharactersListSceneRouterInput {
    func routeToCharacterDetail()
}

protocol CharactersListDataPassing
{
    var dataStore: CharactersListDataStore? { get }
}

public final class CharactersListSceneRouter: NSObject,
                                              CharactersListSceneRouterInput,
                                              CharactersListDataPassing {
    
    weak var viewController: UIViewController?
    var dataStore: CharactersListDataStore?
    
    // MARK: - Routing
    public func routeToCharacterDetail() {
        let destinationVC = GeneralRoute.characterDetail
        navigateCharacterDetail(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    private func navigateCharacterDetail(source: UIViewController, destination: GeneralRoute) {
        guard let destionationVC = destination.module as? CharacterDetailSceneViewController else { return }
        
        source.navigationController?.pushViewController(destionationVC, animated: true)
        
        var destinationDS = destionationVC.router!.dataStore!
        passDataToCharacterDetail(source: dataStore!, destination: &destinationDS)
    }
    
    // MARK: Passing data
    private func passDataToCharacterDetail(source: CharactersListDataStore, destination: inout CharacterDetailDataStore) {
        destination.character = source.character
    }
}
