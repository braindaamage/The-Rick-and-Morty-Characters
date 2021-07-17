//
//  CharactersListSceneModels.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

enum CharactersListSceneModel {
    // MARK: Use cases
    
    enum List {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    enum Character {
        struct Request {
            let id: Int
        }
        struct Response { }
        struct ViewModel { }
    }
}

enum CharactersListServiceModel {
    // MARK: Use cases
    
    enum List {
        struct Request {
            let page: Int
        }
        struct Response { }
        struct ViewModel { }
    }
    
    enum Character {
        struct Request {
            let id: Int
        }
        struct Response { }
        struct ViewModel { }
    }
}
