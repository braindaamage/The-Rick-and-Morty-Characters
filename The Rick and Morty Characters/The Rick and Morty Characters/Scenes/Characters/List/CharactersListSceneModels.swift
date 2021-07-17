//
//  CharactersListSceneModels.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

enum CharactersListSceneModel {
    // MARK: Use cases
    
    enum List {
        struct Request {
            let page: Int
        }
        struct Response {
            let list: [RickAndMortyCharacter]
            let pages: Int
        }
        struct ViewModel {
            let list: [CharactersListSceneModel.DisplayedCharacter]
            let pages: Int
        }
    }
    
    enum Character {
        struct Request {
            let id: Int
        }
        struct Response { }
        struct ViewModel { }
    }
    
    struct DisplayedCharacter {
        let id: Int
        let name: String
        let image: String
    }
}

enum CharactersListServiceModel {
    // MARK: Use cases
    
    enum List {
        struct Request {
            let page: Int
        }
    }
    
    enum Character {
        struct Request {
            let id: Int
        }
    }
}
