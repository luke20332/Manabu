//
//  Collection+Ext.swift
//  Manabu
//
//  Created by Luke on 25/03/2026.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
