//
//  LearnHiraganaViewModel.swift
//  Manabu
//
//  Created by Luke on 11/03/2026.
//

import Foundation

class LearnViewModel: LearnViewModelProtocol {
    let syllabary: SyllabaryType
    
    var seenCharacters: [String] = []
    var currentIndex: Int = 0
    var currentCharacter: String?
    
    lazy var characters: [String] = {
        switch syllabary {
        case .hiragana:
            return Array(hiraganaDict.keys)
        case .katakana:
            return Array(katakanaDict.keys)
        }
    }()
    
    init(syllabary: SyllabaryType) {
        self.syllabary = syllabary
        self.currentCharacter = characters[0]
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
    
    func save() {
        // save characters seen number to coredata
        // ideally save the seen characters as well
    }
}
