//
//  LearnViewModelProtocol.swift
//  Manabu
//
//  Created by Luke on 13/03/2026.
//

import Foundation

protocol LearnViewModelProtocol {
    var syllabary: SyllabaryType { get }
    
    var seenCharacters: [String] { get set }
    var currentIndex: Int { get set }
    var currentCharacter: String? { get set }
    var characters: [String] { get set }
    
    func save()
}
