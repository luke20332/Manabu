//
//  PersistenceManager.swift
//  Manabu
//
//  Created by Luke on 23/01/2026.
//

import Foundation

enum PersistenceActionType {
    case update
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let guessHiraganaHighScore = "guessHiraganaHighScore"
    }
    
    static func retrieveHighScore(completion: @escaping (Result<Int, ManabuError>) -> (Void)) {
        guard let highScoreData = defaults.object(forKey: Keys.guessHiraganaHighScore) as? Data else {
            completion(.success(0))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let highScore = try decoder.decode(Int.self, from: highScoreData)
            completion(.success(highScore))
        } catch {
            completion(.failure(.unableToUpdate))
        }
    }
    
    static func saveHighScores(highScore: Int) -> ManabuError? {
        do {
            let encoder = JSONEncoder()
            let encodedHighScore = try encoder.encode(highScore)
            defaults.set(encodedHighScore, forKey: Keys.guessHiraganaHighScore)
            return nil
        } catch {
            return .unableToUpdate
        }
    }
}
