//
//  Error.swift
//  Manabu
//
//  Created by Luke on 23/01/2026.
//

import Foundation

enum ManabuError: String, Error {
    case unableToUpdate = "Unable to update the cache. Please try again later."
    case unableToFetchScores = "Unable to fetch highScores. Please try again later."
    case unableToFetchSyllabaries = "Unable to fetch Flashcards. Please try again later."
}

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case decodingFailed(underlyingError: Error)
    case dataLoadingFailed(underlingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Could not find the underlying API config file"
        case .decodingFailed(let error):
            return "Failed to decode the API config file: \(error.localizedDescription)"
        case .dataLoadingFailed(let error):
            return "Failed to load the API config file: \(error.localizedDescription)"
        }
    }
}

enum NetworkingError: Error, LocalizedError {
    case missingConfig
    case urlConstructionFailed
    case badURLResponse(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .missingConfig:
            return "Missing configuration file. Please try again"
        case .urlConstructionFailed:
            return "Failed to generate URL. Please try again"
        case .badURLResponse(let error):
            return "Invalid response from URL: \(error.localizedDescription)"
        }
    }
}
