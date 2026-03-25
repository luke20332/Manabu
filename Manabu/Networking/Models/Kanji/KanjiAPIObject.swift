//
//  KanjiAPIObject.swift
//  Manabu
//
//  Created by Luke on 25/03/2026.
//

import Foundation

struct KanjiAPIObject: Decodable {
    let kanji: String
    let heisig: String?
    let meanings: [String]
    let onReadings: [String]
    
    func toModel() -> KanjiInformation {
        .init(
            kanji: self.kanji,
            heisig: self.heisig,
            meanings: self.meanings,
            onReadings: self.onReadings
        )
    }
}
