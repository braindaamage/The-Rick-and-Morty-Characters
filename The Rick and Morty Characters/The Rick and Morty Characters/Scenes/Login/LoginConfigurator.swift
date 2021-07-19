//
//  LoginConfigurator.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 18-07-21.
//

import Foundation

final public class LoginConfigurator {
    // MARK: Object lifecycle
     
    public static let sharedInstance: LoginConfigurator = LoginConfigurator()
    
    private init() { }

    // MARK: Configuration

    public func configure(viewController: LoginViewController) {

        let router = LoginRouter()
        router.viewController = viewController
        
        viewController.router = router
    }
}
