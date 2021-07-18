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
    case login
}

extension GeneralRoute {
    var module: UIViewController? {
        switch self {
        case .characterList:
            return CharactersListSceneViewController()
        case .characterDetail:
            return CharacterDetailSceneViewController()
        case .login:
            return LoginViewController()
        }
    }
}
