//
//  PlayHomeViewModelSpec.swift
//  ManabuTests
//
//  Created by Luke on 27/01/2026.
//

import XCTest
@testable import Manabu

final class PlayHomeViewModelSpec: XCTestCase {
//        func testFetchGames() {
//            let expectedGames: [GameMode] = [
//                GameMode(
//                    imageConfig: .text("お"),
//                    title: "Guess the Hiragana",
//                    highScore: 8,
//                    event: .guessHiraganaTapped,
//                ),
//                GameMode(
//                    imageConfig: .text("a"),
//                    title: "Guess the Romanji",
//                    highScore: 0,
//                    event: .guessRomanjiTapped,
//                ),
//                GameMode(
//                    imageConfig: .image(systemImageName: "pencil.and.outline"),
//                    title: "Draw",
//                    highScore: 0,
//                    event: .drawTapped
//                ),
//                GameMode(
//                    imageConfig: .image(systemImageName: "waveform"),
//                    title: "Listen",
//                    highScore: 0,
//                    event: .listenTapped
//                )
//            ]
//    
//            let builder = Builder()
//            print("1")
//            let sut = builder.make()
//            print("2")
//            let expectation = expectation(description: "Fetch games completes")
//    
//            print("3")
//            builder.persistenceManagerMock.retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidClosure = { completion in
//                print("4")
//                completion(.success(8))
//            }
//    
//            print("5")
//            sut.fetchGames { games in
//                print("6")
//                XCTAssertEqual(games, expectedGames)
//                expectation.fulfill()
//            }
//    
//            print("7")
//            wait(for: [expectation], timeout: 1.0)
//            print("8")
//        }
    func testFetchGames_WithHighScore() {
            // Given
            let mockPersistence = PersistenceManagerProtocolMock()
            mockPersistence.retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidClosure = { completion in
                completion(.success(42))
            }
            
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
            
            XCTAssertTrue(mockPersistence.retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidCalled)
            XCTAssertEqual(receivedGames?.count, 4)
            
            // Verify using forced unwrapping since we know it's not nil after waiting
            let games = try! XCTUnwrap(receivedGames)
            
            XCTAssertEqual(games[0].title, "Guess the Hiragana")
            XCTAssertEqual(games[0].highScore, 42)
            XCTAssertEqual(games[1].title, "Guess the Romanji")
            XCTAssertEqual(games[1].highScore, 0)
            XCTAssertEqual(games[2].title, "Draw")
            XCTAssertEqual(games[2].highScore, 0)
            XCTAssertEqual(games[3].title, "Listen")
            XCTAssertEqual(games[3].highScore, 0)
        }
}

private final class Builder {
    let persistenceManagerMock = PersistenceManagerProtocolMock()
    
    func make() -> PlayHomeViewModel {
        .init(persistenceManager: persistenceManagerMock)
    }
}
