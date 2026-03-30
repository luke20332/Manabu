//
//  LearnHiraganaViewModel.swift
//  Manabu
//
//  Created by Luke on 11/03/2026.
//

import Foundation
import CoreData
import UIKit
import Combine

class LearnViewModel: LearnViewModelProtocol {
    let syllabary: SyllabaryType
    private let context: NSManagedObjectContext
    
    var seenCharacters: [String] = []
    var currentIndex: Int = 0
    var currentCharacter: String?
    var updateCharactersSeen = PassthroughSubject<Int, Never>()
    
    private var syllabaryEntity: SyllabaryEntity?
    private var subscriptions = Set<AnyCancellable>()
    private var currentCharactersSeen: Int = 0
    
    
    lazy var characters: [String] = {
        switch syllabary {
        case .hiragana:
            return Array(hiraganaDict.keys)
        case .katakana:
            return Array(katakanaDict.keys)
        case .romanji:
            return []
        case .kanji:
            return []
        }
    }()
    
    init(syllabary: SyllabaryType, context: NSManagedObjectContext) {
        self.syllabary = syllabary
        self.context = context
        self.currentCharacter = characters[0]
        setupSubscriptions()
        do {
            try fetchSyllabaryEntity()
        } catch {
            return
        }
    }
    
    func setupSubscriptions() {
        updateCharactersSeen
            .sink { _ in
            } receiveValue: { [weak self] result in
                self?.syllabaryEntity?.charactersSeen = Int64(result)
                do {
                    try self?.save()
                } catch {
                    return
                }
            }
            .store(in: &subscriptions)
    }
    
    @objc func nextCharacter() -> String? {
        currentIndex += 1
        currentCharacter = characters[currentIndex]
        
        guard let currentCharacter else {
            return nil
        }
        seenCharacters.append(currentCharacter)
        return currentCharacter
    }
    
    @objc func previousCharacter() -> String? {
        if seenCharacters.count < 1 || currentIndex == 0 {
            currentCharacter = characters[0]
        } else {
            currentIndex -= 1
            currentCharacter = characters[currentIndex]
        }
        return currentCharacter
    }
    
    func fetchSyllabaryEntity() throws {
        let request: NSFetchRequest<SyllabaryEntity> =  SyllabaryEntity.fetchRequest()
        
        request.predicate = NSPredicate(format: "title contains[c] %@", syllabary.rawValue)
        request.fetchLimit = 1
        
        guard let entity = try context.fetch(request).first else {
            throw ManabuError.unableToFetchSyllabaries
        }
        
        syllabaryEntity = entity
    }
    
    func incrementCharactersSeen() {
        currentCharactersSeen += 1
        updateCharactersSeen.send(currentCharactersSeen)
    }
    
    func save() throws {
        do {
            try self.context.save()
        } catch {
            print("Saving error")
            throw ManabuError.unableToUpdate
        }
    }
}
