//
//  Error.swift
//  Manabu
//
//  Created by Luke on 23/01/2026.
//

import Foundation

enum ManabuError: String, Error {
    case unableToUpdate = "Unable to update the cache. Please try again later."
    case unableToFetchScores = "Unable to fetch highScores. Please try again later"
}
