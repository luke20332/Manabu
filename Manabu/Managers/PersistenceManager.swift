//
//  PersistenceManager.swift
//  Manabu
//
//  Created by Luke on 23/01/2026.
//

import Foundation

// sourcery: AutoMockable
protocol PersistenceManagerProtocol {
    func retrieveHighScore(completion: @escaping (Result<Int, ManabuError>) -> (Void))
    func saveHighScores(highScore: Int) -> ManabuError?
}

enum PersistenceManager: PersistenceManagerProtocol {
    
    static private let defaults = UserDefaults.standard
    
    static var current: PersistenceManagerProtocol = PersistenceManager.live
    
    case live
    
    enum Keys {
        static let guessHiraganaHighScore = "guessHiraganaHighScore"
    }
    
    func retrieveHighScore(completion: @escaping (Result<Int, ManabuError>) -> (Void)) {
        guard let highScoreData = PersistenceManager.defaults.object(forKey: Keys.guessHiraganaHighScore) as? Data else {
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
    
    func saveHighScores(highScore: Int) -> ManabuError? {
        do {
            let encoder = JSONEncoder()
            let encodedHighScore = try encoder.encode(highScore)
            PersistenceManager.defaults.set(encodedHighScore, forKey: Keys.guessHiraganaHighScore)
            return nil
        } catch {
            return .unableToUpdate
        }
    }
}
