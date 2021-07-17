//
//  CharactersListSceneViewController.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import UIKit

class CharactersListSceneViewController: UIViewController {
    
    var interactor: CharactersListBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = CharactersListSceneInteractor()
        viewController.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        fetchNextPage()
    }
    
    // MARK: Settings
    
    private func settingView() {
        title = "R&M Characters"
        view.backgroundColor = .systemBackground
    }
    
    // MARK: Privates
    
    private func fetchNextPage() {
        let request = CharactersListSceneModel.List.Request()
        interactor?.fetchNextCharactersPage(request: request)
        
        // Test get character
        let requestCharacter = CharactersListSceneModel.Character.Request(id: 1)
        interactor?.fetchCharacter(request: requestCharacter)
    }
}
