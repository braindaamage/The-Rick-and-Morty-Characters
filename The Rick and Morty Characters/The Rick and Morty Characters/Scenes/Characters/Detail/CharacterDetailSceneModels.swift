//
//  CharacterDetailSceneModels.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

enum CharacterDetailSceneModels {
    enum Detail {
        struct Request { }
        struct Response {
            let character: RickAndMortyCharacter
        }
        struct ViewModel {
            let id: Int
            let name: String
            let image: String
            let status: String
            let species: String
            let type: String
            let gender: String
            let origin: String
            let location: String
            
            func avatarImageView(withFrame frame: CGRect) -> UIImageView {
                let image = UIImageView(frame: frame)
                image.imageFromURL(urlString: self.image, withDefaultImage: UIImage(named: "RMLogo"))
                image.layer.cornerRadius = 20
                image.layer.masksToBounds = true
                
                return image
            }
        }
    }
}
