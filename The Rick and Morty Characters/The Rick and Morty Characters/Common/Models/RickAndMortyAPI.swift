//
//  RickAndMortyAPI.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

struct RickAndMortyAPIInfo: Codable {
    let count: Int
    let pages: Int
}

struct RickAndMortyAPI {
    struct Characters {
        struct List: Codable {
            let info: RickAndMortyAPIInfo
            let results: [RickAndMortyCharacter]
        }
    }
}
