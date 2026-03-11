//
//  LearnHiraganaViewModel.swift
//  Manabu
//
//  Created by Luke on 11/03/2026.
//

import Foundation

class LearnHiraganaViewModel {
    let syllabary: SyllabaryType
    
    var seenCharacters: [String] = []
    var currentCharacter: String?
    
    init(syllabary: SyllabaryType) {
        self.syllabary = syllabary
        self.currentCharacter = nextCharacter()
    }
    
    @objc func nextCharacter() -> String? {
        switch syllabary {
        case .hiragana:
            currentCharacter = hiraganaDict.randomElement()!.key
        case .katakana:
            currentCharacter = katakanaDict.randomElement()!.key
        }
        
        guard let currentCharacter else {
            return nil
        }
        
        seenCharacters.append(currentCharacter)
        return currentCharacter
    }
    
    @objc func previousCharacter() -> String? {
        if seenCharacters.count < 1 {
            return nil
        } else {
            return seenCharacters.last
        }
    }
    
    func save() {
        // save characters seen number to coredata
        // ideally save the seen characters as well
    }
}

enum SyllabaryType {
    case hiragana
    case katakana
}
