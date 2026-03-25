//
//  APIConfig.swift
//  Manabu
//
//  Created by Luke on 25/03/2026.
//

import Foundation

struct APIConfig: Decodable {
    let kanjiBaseURL: String
    
    static let shared: APIConfig? = {
        do {
            return try loadConfig()
        } catch {
            return nil
        }
    }()
    
    private static func loadConfig() throws -> APIConfig {
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json") else {
            throw APIConfigError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(APIConfig.self, from: data)
        } catch let error as DecodingError {
            throw APIConfigError.decodingFailed(underlyingError: error)
        } catch {
            throw APIConfigError.dataLoadingFailed(underlingError: error)
        }
    }
}
