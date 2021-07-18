//
//  Character.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

struct RickAndMortyCharacter: Codable {
    let id: Int
    let name: String
    let status: RickAndMortyCharacter.Status
    let species: String
    let type: String
    let gender: RickAndMortyCharacter.Gender
    let origin: RickAndMortyCharacter.Origin
    let location: RickAndMortyCharacter.Location
    let image: String
    
    enum Status: String, Codable {
        case Alive
        case Dead
        case unknown
    }
    
    enum Gender: String, Codable {
        case Female
        case Male
        case Genderless
        case unknown
    }
    
    struct Origin: Codable {
        let name: String
    }
    
    struct Location: Codable {
        let name: String
    }
}
