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
}
