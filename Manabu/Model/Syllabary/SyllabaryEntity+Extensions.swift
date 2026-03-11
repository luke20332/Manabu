//
//  SyllabaryEntity+Extensions.swift
//  Manabu
//
//  Created by Luke on 10/03/2026.
//

import Foundation

extension SyllabaryEntity {
    func toModel() -> Syllabary {
        return .init(
            title: self.title ?? "",
            image: self.image ?? "",
            charactersSeen: Int(self.charactersSeen),
            totalCharacters: Int(self.totalCharacters),
            event: LearnEvent(rawValue: self.eventRaw!)!
        )
    }
}
