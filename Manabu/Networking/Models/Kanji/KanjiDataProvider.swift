//
//  RandomKanjiDataProvider.swift
//  Manabu
//
//  Created by Luke on 25/03/2026.
//

import Foundation

protocol KanjiDataProviderProtocol {
    var urlSession: URLSession { get }
    func fetchKanjiInformation(_ kanji: String) async throws -> KanjiAPIObject
}

final class KanjiDataProvider: KanjiDataProviderProtocol {
    var urlSession: URLSession
    
    let kanjiBaseURL = APIConfig.shared?.kanjiBaseURL
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchKanjiInformation(_ kanji: String) async throws -> KanjiAPIObject {
        guard let kanjiBaseURL else {
            throw NetworkingError.missingConfig
        }
        let kanjiURLString = kanjiBaseURL + kanji
        
        print(kanjiURLString)
        
        let kanjiURL = URL(string: kanjiURLString)
        
        guard let kanjiURL else {
            throw NetworkingError.urlConstructionFailed
        }
        
        let (data, urlResponse) = try await urlSession.data(from: kanjiURL)
        
        guard let response = urlResponse as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw NetworkingError.badURLResponse(
                underlyingError: NSError(
                    domain: "KanjiDataProvider",
                    code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                    userInfo: [NSLocalizedDescriptionKey: "Bad response from server"]
                )
            )
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(KanjiAPIObject.self, from: data)
    }
}
