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

struct PersistenceManager: PersistenceManagerProtocol {
    
    private let defaults: UserDefaults
    
    enum Keys {
        static let guessHiraganaHighScore = "guessHiraganaHighScore"
    }
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func retrieveHighScore(completion: @escaping (Result<Int, ManabuError>) -> (Void)) {
        guard let highScoreData = defaults.object(forKey: Keys.guessHiraganaHighScore) as? Data else {
            completion(.success(0))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let highScore = try decoder.decode(Int.self, from: highScoreData)
            completion(.success(highScore))
        } catch {
            completion(.failure(.unableToFetch))
        }
    }
    
    func saveHighScores(highScore: Int) -> ManabuError? {
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
