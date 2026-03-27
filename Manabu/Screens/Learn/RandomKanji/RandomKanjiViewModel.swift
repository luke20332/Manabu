//
//  RandomKanjiViewModel.swift
//  Manabu
//
//  Created by Luke on 25/03/2026.
//

import Foundation

protocol RandomKanjiViewModelProtocol {
    var dataProvider: KanjiDataProviderProtocol { get set }
    
    func getRandomCharacter() -> String
    func fetchCharacterInformation(character: String) async throws -> KanjiInformation
    
    func translate(_ hiragana: String) -> String?
}

final class RandomKanjiViewModel: RandomKanjiViewModelProtocol {
    var dataProvider: KanjiDataProviderProtocol
    
    init(dataProvider: KanjiDataProviderProtocol = KanjiDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func getRandomCharacterFromCJK() -> Character {
        let start: UInt32 = 0x4E00
        let end: UInt32 = 0x9FFF
        let randomCodePoint = UInt32.random(in: start...end)
        return Character(UnicodeScalar(randomCodePoint)!)
    }
    
    func getRandomCharacter() -> String {
        joyoKanjiDict.randomElement()!
    }
    
    func fetchCharacterInformation(character: String) async throws -> KanjiInformation {
        return try await dataProvider.fetchKanjiInformation(character).toModel()
    }
    
    func translate(_ hiragana: String) -> String? {
        hiragana.applyingTransform(.hiraganaToKatakana, reverse: false)
            .flatMap { $0.applyingTransform(.latinToKatakana, reverse: true) }
    }
}
