//
//  PlayHomeViewModelSpec.swift
//  ManabuTests
//
//  Created by Luke on 27/01/2026.
//

import XCTest
@testable import Manabu

final class PlayHomeViewModelSpec: XCTestCase {
    func testFetchGames() {
        let expectedGames: [GameMode] = [
            GameMode(
                imageConfig: .text("お"),
                title: "Guess the Hiragana",
                highScore: 8,
                event: .guessHiraganaTapped,
            ),
            GameMode(
                imageConfig: .text("a"),
                title: "Guess the Romanji",
                highScore: 0,
                event: .guessRomanjiTapped,
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
        
        let builder = Builder()
        let sut = builder.make()
        let expectation = expectation(description: "Fetch games completes")
        
        sut.fetchGames { games in
            XCTAssertEqual(games, expectedGames)
            expectation.fulfill()
        }
    }
}

private final class Builder {
    func make() -> PlayHomeViewModel {
        .init()
    }
}
