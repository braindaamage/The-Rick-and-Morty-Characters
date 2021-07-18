//
//  LoginConfigurator.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 18-07-21.
//

import Foundation

class LoginConfigurator {
    // MARK: Object lifecycle
     
    static let sharedInstance: LoginConfigurator = {
        LoginConfigurator()
    }()

    // MARK: Configuration

    func configure(viewController: LoginViewController) {

        let router = LoginRouter()
        router.viewController = viewController
        
        viewController.router = router
    }
}
