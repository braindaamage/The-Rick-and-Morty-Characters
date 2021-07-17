//
//  CharacterDetailSceneViewController.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

protocol CharacterDetailSceneDisplayLogic: AnyObject {
    func displayDetail(viewModel: CharacterDetailSceneModels.Detail.ViewModel)
}

class CharacterDetailSceneViewController: UIViewController {
    // MARK: Object lifecycle
    
    var interactor: CharacterDetailBusinessLogic?
    var router: (NSObjectProtocol & CharacterDetailRoutingLogic & CharacterDetailDataPassing)?
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        settingStackView()
        fetchCharacterData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        stackView.frame = view.bounds
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = CharacterDetailSceneInteractor()
        let presenter = CharacterDetailScenePresenter()
        let router = CharacterDetailSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Setting View
    
    private func settingView() {
        title = "Loading..."
        view.backgroundColor = .systemBackground
    }
    
    // MARK: Setting StackView
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    private func settingStackView() {
        view.addSubview(stackView)
        configureStackViewConstraints()
    }
    
    private func configureStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    // MARK: Privates
    
    private func fetchCharacterData() {
        let request = CharacterDetailSceneModels.Detail.Request()
        interactor?.fetchCharacterData(request: request)
    }
    
    private func displayCharacterName(withText name: String) {
        title = name
    }
    
    private func displayCharacterAvatar(withImageView image: UIImageView) {
        stackView.addArrangedSubview(image)
    }
    
    private func displayMoreData(withString text: String, forTitle title: String) {
        let textLabel = UILabel()
        textLabel.text = "\(title): \(text)"
        
        stackView.addArrangedSubview(textLabel)
    }
}

// MARK: - CharacterDetailSceneDisplayLogic
extension CharacterDetailSceneViewController: CharacterDetailSceneDisplayLogic {
    func displayDetail(viewModel: CharacterDetailSceneModels.Detail.ViewModel) {
        displayCharacterName(withText: viewModel.name)
        displayCharacterAvatar(withImageView: viewModel.avatarImageView(withFrame: CGRect(x: 0, y: 0, width: 40, height: 40)))
        
        displayMoreData(withString: viewModel.status, forTitle: "Status")
        displayMoreData(withString: viewModel.species, forTitle: "Specie")
        displayMoreData(withString: viewModel.type, forTitle: "Type")
        displayMoreData(withString: viewModel.gender, forTitle: "Gender")
        displayMoreData(withString: viewModel.origin, forTitle: "Origin")
        displayMoreData(withString: viewModel.location, forTitle: "Location")
    }
}
