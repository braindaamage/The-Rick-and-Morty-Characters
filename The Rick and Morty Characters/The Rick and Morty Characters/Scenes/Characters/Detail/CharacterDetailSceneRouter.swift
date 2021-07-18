//
//  CharacterDetailSceneRouter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

@objc protocol CharacterDetailRoutingLogic
{
}

protocol CharacterDetailDataPassing
{
    var dataStore: CharacterDetailDataStore? { get }
}

class CharacterDetailSceneRouter: NSObject, CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    
    weak var viewController: UIViewController?
    var dataStore: CharacterDetailDataStore?
    
}
