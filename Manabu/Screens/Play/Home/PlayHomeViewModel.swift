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
                image: Images.a_hiragana,
                title: "Guess the hiragana",
                highScore: guessHiraganaHighScore,
                event: .guessHiraganaTapped
            )
            let guessRomanji = GameMode(
                image: Images.a_english,
                title: "Guess the romanji",
                highScore: 0,
                event: .guessRomanjiTapped
            )
            let draw = GameMode(
                image: SFSymbols.draw,
                title: "Draw",
                highScore: 0,
                event: .drawTapped
            )
            let listen = GameMode(
                image: SFSymbols.listen,
                title: "Listen",
                highScore: 0,
                event: .listenTapped
            )
            
            completion([guessHiragana, guessRomanji, draw, listen])
        }
    }
}
