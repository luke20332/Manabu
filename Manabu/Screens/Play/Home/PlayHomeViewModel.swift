//
//  PlayHomeViewModel.swift
//  Manabu
//
//  Created by Luke on 23/01/2026.
//

import Foundation

final class PlayHomeViewModel {
    func fetchGames(completion: @escaping ([GameMode]) -> Void) {
        PersistenceManager.retrieveHighScore { result in
            let guessHiraganaHighScore: Int
            
            switch result {
            case .success(let highScore):
                guessHiraganaHighScore = highScore
            case .failure(_):
                guessHiraganaHighScore = 0
            }
            
            let guessHiragana = GameMode(
                imageConfig: .text("お"),
                title: "Guess the Hiragana",
                highScore: guessHiraganaHighScore,
                event: .guessHiraganaTapped,
            )
            let guessRomanji = GameMode(
                imageConfig: .text("a"),
                title: "Guess the Romanji",
                highScore: 0,
                event: .guessRomanjiTapped,
            )
            let draw = GameMode(
                imageConfig: .image(SFSymbols.draw),
                title: "Draw",
                highScore: 0,
                event: .drawTapped
            )
            let listen = GameMode(
                imageConfig: .image(SFSymbols.listen),
                title: "Listen",
                highScore: 0,
                event: .listenTapped
            )
            
            completion([guessHiragana, guessRomanji, draw, listen])
        }
    }
}
