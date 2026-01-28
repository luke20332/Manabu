//
//  TestSpec.swift
//  ManabuTests
//
//  Created by Luke on 28/01/2026.
//

import XCTest
@testable import Manabu

final class PlayHomeViewModelTests: XCTestCase {
    
    // Simple custom mock
    final class SimplePersistenceMock: PersistenceManagerProtocol {
        var resultToReturn: Result<Int, ManabuError> = .success(0)
        
        func retrieveHighScore(completion: @escaping (Result<Int, ManabuError>) -> Void) {
            completion(resultToReturn)
        }
        
        func saveHighScores(highScore: Int) -> ManabuError? {
            return nil
        }
    }
    
    func testFetchGames_WithHighScore() {
        // Given
        let mockPersistence = SimplePersistenceMock()
        mockPersistence.resultToReturn = .success(42)
        
        let viewModel = PlayHomeViewModel(persistenceManager: mockPersistence)
        let expectation = expectation(description: "Fetch games completion")
        var receivedGames: [GameMode]?
        
        // When
        viewModel.fetchGames { games in
            receivedGames = games
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertNotNil(receivedGames)
        XCTAssertEqual(receivedGames?.count, 4)
        
        guard let games = receivedGames else {
            XCTFail("Games should not be nil")
            return
        }
        
        XCTAssertEqual(games[0].title, "Guess the Hiragana")
        XCTAssertEqual(games[0].highScore, 42)
        XCTAssertEqual(games[1].highScore, 0)
        XCTAssertEqual(games[2].highScore, 0)
        XCTAssertEqual(games[3].highScore, 0)
    }
    
    func testFetchGames_WithNoHighScore() {
        // Given
        let mockPersistence = SimplePersistenceMock()
        mockPersistence.resultToReturn = .success(0)
        
        let viewModel = PlayHomeViewModel(persistenceManager: mockPersistence)
        let expectation = expectation(description: "Fetch games completion")
        var receivedGames: [GameMode]?
        
        // When
        viewModel.fetchGames { games in
            receivedGames = games
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(receivedGames?[0].highScore, 0)
    }
    
    func testFetchGames_WithPersistenceError_DefaultsToZero() {
        // Given
        let mockPersistence = SimplePersistenceMock()
        mockPersistence.resultToReturn = .failure(.unableToUpdate)
        
        let viewModel = PlayHomeViewModel(persistenceManager: mockPersistence)
        let expectation = expectation(description: "Fetch games completion")
        var receivedGames: [GameMode]?
        
        // When
        viewModel.fetchGames { games in
            receivedGames = games
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(receivedGames?[0].highScore, 0)
    }
    
    func testFetchGames_ReturnsExpectedGameModes() {
        // Given
        let mockPersistence = SimplePersistenceMock()
        mockPersistence.resultToReturn = .success(100)
        
        let viewModel = PlayHomeViewModel(persistenceManager: mockPersistence)
        let expectation = expectation(description: "Fetch games completion")
        var receivedGames: [GameMode]?
        
        let expectedGames = [
            GameMode(
                imageConfig: .text("お"),
                title: "Guess the Hiragana",
                highScore: 100,
                event: .guessHiraganaTapped
            ),
            GameMode(
                imageConfig: .text("a"),
                title: "Guess the Romanji",
                highScore: 0,
                event: .guessRomanjiTapped
            ),
            GameMode(
                imageConfig: .image(systemImageName: "pencil.and.outline"),
                title: "Draw",
                highScore: 0,
                event: .drawTapped
            ),
            GameMode(
                imageConfig: .image(systemImageName: "waveform"),
                title: "Listen",
                highScore: 0,
                event: .listenTapped
            )
        ]
        
        // When
        viewModel.fetchGames { games in
            receivedGames = games
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(receivedGames, expectedGames)
    }
}
