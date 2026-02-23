//
//  PlayHomeViewModel.swift
//  Manabu
//
//  Created by Luke on 23/01/2026.
//

import Foundation
import UIKit
import CoreData

final class PlayHomeViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var gameModeEntities: [GameModeEntity]?
    
    func fetchGames(completion: @escaping (Result<[GameMode], Error>) -> Void) {
        do {
            self.gameModeEntities = try context.fetch(GameModeEntity.fetchRequest())
                
            guard let gameModeEntities else {
                return completion(.failure(ManabuError.unableToFetchScores))
            }
            
            let gameModes = gameModeEntities.map {
                $0.toModel()
            }
            
            completion(.success(gameModes))
        } catch {
            completion(.failure(ManabuError.unableToFetchScores))
        }
    }

//    func oldFetchGames(completion: @escaping ([GameMode]) -> Void) {
//        PersistenceManager.retrieveHighScore { result in
//            let guessHiraganaHighScore: Int
//            
//            switch result {
//            case .success(let highScore):
//                guessHiraganaHighScore = highScore
//            case .failure(_):
//                guessHiraganaHighScore = 0
//            }
//            
//            let guessHiragana = GameMode(
//                imageConfig: .text("お"),
//                title: "Guess the Hiragana",
//                highScore: guessHiraganaHighScore,
//                event: .guessHiraganaTapped,
//            )
//            let guessRomanji = GameMode(
//                imageConfig: .text("a"),
//                title: "Guess the Romanji",
//                highScore: 0,
//                event: .guessRomanjiTapped,
//            )
//            let draw = GameMode(
//                imageConfig: .image("draw"),
//                title: "Draw",
//                highScore: 0,
//                event: .drawTapped
//            )
//            let listen = GameMode(
//                imageConfig: .image("listen"),
//                title: "Listen",
//                highScore: 0,
//                event: .listenTapped
//            )
//            
//            completion([guessHiragana, guessRomanji, draw, listen])
//        }
//    }
}
