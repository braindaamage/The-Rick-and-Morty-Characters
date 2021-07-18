//
//  RickAndMortyAPICallerTests.swift
//  The Rick and Morty Characters Tests
//
//  Created by Leonardo Olivares on 17-07-21.
//

@testable import The_Rick_and_Morty_Characters
import XCTest

class RickAndMortyAPICallerTests: XCTestCase {
    
    var characterListMock: RickAndMortyAPI.Characters.List!
    var sessionMock: URLSession!
    
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "charactersPage1", ofType: "json") else {
            XCTFail("charactersPage1.json not found")
            return
        }

        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            XCTFail("Unable to convert charactersPage1.json to String")
            return
        }

        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Unable to convert charactersPage1.json to Data")
            return
        }
        
        guard let characterList = try? JSONDecoder().decode(RickAndMortyAPI.Characters.List.self, from: jsonData) else {
            XCTFail("Couldn't convert data to list")
            return
        }
        
        self.characterListMock = characterList
        
        let urlString = URL(string: "\(RickAndMortyAPICaller.Constant.baseAPIURL)/?page=1")
        URLProtocolMock.testURLs = [urlString: jsonData]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        self.sessionMock = URLSession(configuration: config)
    }
    
    override func tearDown() {
        self.characterListMock = nil
        self.sessionMock = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testFetchValidData() throws {
        guard let characterList = self.characterListMock else {
            XCTFail("Expected non-nil list")
            return
        }
        
        let expectation = expectation(description: "API service get data and runs the callback closure")
        
        let apiCaller = RickAndMortyAPICaller(withSession: self.sessionMock)
        apiCaller.getCharactersByPage(1) { result in
            switch result {
            case .success(let data):
                XCTAssertTrue(data.info.pages == characterList.info.pages)
                XCTAssertTrue(data.results.first?.id == characterList.results.first?.id)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testInvalidJsonData() throws {
        let urlString = URL(string: "\(RickAndMortyAPICaller.Constant.baseAPIURL)/?page=100")
        let data = "invalid data".data(using: .utf8)!
        
        URLProtocolMock.testURLs = [urlString: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        self.sessionMock = URLSession(configuration: config)
        
        let expectation = expectation(description: "API service get data and runs the callback closure")
        
        let apiCaller = RickAndMortyAPICaller(withSession: self.sessionMock)
        apiCaller.getCharactersByPage(100) { result in
            switch result {
            case .success:
                XCTFail("Expected failed case")
                break
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
