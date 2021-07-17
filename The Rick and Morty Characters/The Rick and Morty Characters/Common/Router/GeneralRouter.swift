//
//  GeneralRouter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

enum GeneralRoute {
    case characterList
    case characterDetail
}

extension GeneralRoute {
    var module: UIViewController? {
        switch self {
        case .characterList:
            return CharactersListSceneViewController()
        case .characterDetail:
            return CharacterDetailSceneViewController()
        }
    }
}
