//
//  CharacterDetailSceneRouter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

@objc protocol CharacterDetailSceneRouterInput { }

protocol CharacterDetailDataPassing {
    var dataStore: CharacterDetailDataStore? { get }
}

public final class CharacterDetailSceneRouter: NSObject,
                                               CharacterDetailSceneRouterInput,
                                               CharacterDetailDataPassing {
    
    weak var viewController: UIViewController?
    var dataStore: CharacterDetailDataStore?
}
