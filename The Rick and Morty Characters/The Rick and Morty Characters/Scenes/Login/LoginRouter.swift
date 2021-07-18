//
//  LoginRouter.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

@objc protocol LoginRouterInput
{
    func routeToNextScreen()
}

class LoginRouter: NSObject, LoginRouterInput {
    weak var viewController: UIViewController?
    
    //MARK: Routing
    func routeToNextScreen() {
        let destionationVC = GeneralRoute.characterList
        navigateToNextScreen(source: viewController!, destination: destionationVC)
    }
    
    // MARK: Navigation
    func navigateToNextScreen(source: UIViewController, destination: GeneralRoute) {
        guard let destionationVC = destination.module else { fatalError() }
        let navigationVC = UINavigationController(rootViewController: destionationVC)
        navigationVC.navigationBar.prefersLargeTitles = true
        navigationVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.setRootViewController(navigationVC,
                                                                                                                options: .init(direction: .toTop,
                                                                                                                               style: .easeInOut))
    }
}
