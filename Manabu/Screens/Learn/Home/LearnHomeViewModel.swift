//
//  LearnViewModel.swift
//  Manabu
//
//  Created by Luke on 10/03/2026.
//

import Foundation
import UIKit
import CoreData

final class LearnViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var syllabaryEntities: [SyllabaryEntity]?
    
    func fetchSyllabaries(completion: @escaping (Result<[Syllabary], Error>) -> Void) {
        do {
            self.syllabaryEntities = try context.fetch(SyllabaryEntity.fetchRequest())
            
            guard let syllabaryEntities else {
                return completion(.failure(ManabuError.unableToFetchScores))
            }
            
            let syllabaries = syllabaryEntities.map {
                $0.toModel()
            }
            
            completion(.success(syllabaries))
        } catch {
            completion(.failure(ManabuError.unableToFetchSyllabaries))
        }
    }
}
