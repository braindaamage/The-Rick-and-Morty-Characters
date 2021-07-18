//
//  CharactersListSceneRouter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

@objc protocol CharactersListSceneRouterInput
{
    func routeToCharacterDetail()
}

protocol CharactersListDataPassing
{
    var dataStore: CharactersListDataStore? { get }
}

class CharactersListSceneRouter: NSObject, CharactersListSceneRouterInput, CharactersListDataPassing {
    
    weak var viewController: UIViewController?
    var dataStore: CharactersListDataStore?
    
    // MARK: - Routing
    func routeToCharacterDetail() {
        let destinationVC = GeneralRoute.characterDetail
        navigateCharacterDetail(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateCharacterDetail(source: UIViewController, destination: GeneralRoute) {
        guard let destionationVC = destination.module as? CharacterDetailSceneViewController else { return }
        
        source.navigationController?.pushViewController(destionationVC, animated: true)
        
        var destinationDS = destionationVC.router!.dataStore!
        passDataToCharacterDetail(source: dataStore!, destination: &destinationDS)
    }
    
    // MARK: Passing data
    func passDataToCharacterDetail(source: CharactersListDataStore, destination: inout CharacterDetailDataStore) {
        destination.character = source.character
    }
}
