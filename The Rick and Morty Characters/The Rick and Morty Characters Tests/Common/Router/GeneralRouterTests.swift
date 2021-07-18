//
//  GeneralRouterTest.swift
//  The Rick and Morty Characters Tests
//
//  Created by Leonardo Olivares on 17-07-21.
//

@testable import The_Rick_and_Morty_Characters
import XCTest

class GeneralRouterTests: XCTestCase {
    
    func testIsValidCharacterListViewController() throws {
        guard let charactersListVC = GeneralRoute.characterList.module else {
            XCTFail("Expected non-nil View Controller")
            return
        }
        
        XCTAssertTrue(charactersListVC is CharactersListSceneViewController)
    }
    
    func testIsValidCharacterDetailViewControoler() throws {
        guard let characterDetailVC = GeneralRoute.characterDetail.module else {
            XCTFail("Expected non-nil View Controller")
            return
        }
        
        XCTAssertTrue(characterDetailVC is CharacterDetailSceneViewController)
    }
    
    func testIsValidLoginViewController() throws {
        guard let loginVC = GeneralRoute.login.module else {
            XCTFail("Expected non-nil VIew Controller")
            return
        }
        
        XCTAssertTrue(loginVC is LoginViewController)
    }
}
