//
//  LoginViewController.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    let gidButton: GIDSignInButton = {
        let gidButton = GIDSignInButton(frame: .zero)
        gidButton.style = .wide
        
        return gidButton
    }()
    
    let msgLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        
        return label
    }()
    
    // MARK: Object lifecycle
    
    var router: (NSObjectProtocol & LoginRouterInput)?
    
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
    }
    
    // MARK: Setup
    
    private func setup()
    {
        LoginConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: Setting View
    
    private func settingView() {
        view.backgroundColor = .systemBackground
        view.addSubview(gidButton)
        view.addSubview(msgLabel)
        configureGIDButtonConstraints()
        configureMsgLabelConstraints()
        configureButtonAction()
    }
    
    private func configureGIDButtonConstraints() {
        gidButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gidButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gidButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ])
    }
    
    private func configureMsgLabelConstraints() {
        msgLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            msgLabel.topAnchor.constraint(equalTo: gidButton.bottomAnchor, constant: 20),
            msgLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureButtonAction() {
        gidButton.addTarget(self, action: #selector(didTapGIDButton), for: .touchUpInside)
    }
    
    @objc func didTapGIDButton(_: UIButton) {
        makeGoogleLogin()
    }
    
    // MARK: Privates
    
    private func makeGoogleLogin() {
        msgLabel.text = ""
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [weak self] user, error in
            if error != nil || user == nil {
                self?.msgLabel.text = "Ocurrio un error o se canceló el intento"
            } else {
                self?.prepareForNextScreen()
            }
        }
    }
    
    private func prepareForNextScreen() {
        router?.routeToNextScreen()
    }
}
