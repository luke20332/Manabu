//
//  PersistenceManagerSpec.swift
//  ManabuTests
//
//  Created by Luke on 28/01/2026.
//

import Testing
import XCTest
@testable import Manabu

final class PersistenceManagerSpec: XCTestCase {
    var sut: PersistenceManager!
    var testDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        
        testDefaults = UserDefaults(suiteName: "TestDefaults")!
        
        sut = PersistenceManager.init(defaults: testDefaults)
    }
    
    override func tearDown() {
        testDefaults.removePersistentDomain(forName: "TestDefaults")
        testDefaults = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - retrieveHighScore
    
    func test_retrieveHighScore_whenNoDataExists_returnsZero() {
        let expectation = expectation(description: "Completion Called")
        var result: Result<Int, ManabuError>?
        
        sut.retrieveHighScore { resultReceived in
            result = resultReceived
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        guard case .success(let score) = result else {
            XCTFail("expected success")
            return
        }
        XCTAssertEqual(score, 0)
    }
    
    func test_retrieveHighScore_whenDataExists_returnsSavedValue() {
        // Setup
        let expectedScore = 5
        let encoder = JSONEncoder()
        let encodedScore = try! encoder.encode(expectedScore)
        testDefaults.set(encodedScore, forKey: PersistenceManager.Keys.guessHiraganaHighScore)
        
        let expectation = expectation(description: "Completion Called")
        var result: Result<Int, ManabuError>?
        
        sut.retrieveHighScore { resultRecieved in
            result = resultRecieved
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        guard case .success(let score) = result else {
            XCTFail("expected success")
            return
        }
        
        XCTAssertEqual(score, 5)
    }
    
    func test_retrieveHighScore_whenCorruptedDataExists_returnsZero() {
        let corruptedData = "invalid json".data(using: .utf8)!
        testDefaults.set(corruptedData, forKey: PersistenceManager.Keys.guessHiraganaHighScore)
        
        let expectation = expectation(description: "Completion Called")
        var result: Result<Int, ManabuError>?
        
        sut.retrieveHighScore { resultRecieved in
            result = resultRecieved
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        guard case .failure(let error) = result else {
            XCTFail("expected failure")
            return
        }
        
        XCTAssertEqual(error, .unableToFetch)
    }
    
    // MARK: - saveHighScores
    
    func test_saveHighScores_withValidScore_returnsSuccessfully() {
        // given
        let newHighScore: Int = 10
        
        // when
        let error = sut.saveHighScores(highScore: newHighScore)
        
        XCTAssertNil(error)
        
        let savedData = testDefaults.data(forKey: PersistenceManager.Keys.guessHiraganaHighScore)
        
        XCTAssertNotNil(savedData)
        
        let decoder = JSONDecoder()
        let decodedScore = try? decoder.decode(Int.self, from: savedData!)
        
        // then
        
        XCTAssertEqual(decodedScore, newHighScore)
    }
    
    func test_saveHighScores_overwritesExistingHighScore() {
        let oldHighScore: Int = 5
        let newHighScore: Int = 10
        
        _ = sut.saveHighScores(highScore: oldHighScore)
        
        let error = sut.saveHighScores(highScore: newHighScore)
        
        XCTAssertNil(error)
        
        let expectation = expectation(description: "completion called")
        sut.retrieveHighScore { result in
            if case .success(let score) = result {
                XCTAssertEqual(score, newHighScore)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
