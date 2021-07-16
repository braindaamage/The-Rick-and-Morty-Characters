//
//  CharactersListSceneViewController.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import UIKit

class CharactersListSceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
    }
    
    // MARK: Settings
    
    private func settingView() {
        title = "R&M Characters"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
