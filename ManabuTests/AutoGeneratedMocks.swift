// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif


@testable import Manabu
























class PersistenceManagerProtocolMock: PersistenceManagerProtocol {




    //MARK: - retrieveHighScore

    var retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidCallsCount = 0
    var retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidCalled: Bool {
        return retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidCallsCount > 0
    }
    var retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidReceivedCompletion: (((Result<Int, ManabuError>) -> Void))?
    var retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidReceivedInvocations: [(((Result<Int, ManabuError>) -> Void))] = []
    var retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidClosure: ((@escaping (Result<Int, ManabuError>) -> Void) -> Void)?

    func retrieveHighScore(completion: @escaping (Result<Int, ManabuError>) -> Void) {
        retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidCallsCount += 1
        retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidReceivedCompletion = completion
        retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidReceivedInvocations.append(completion)
        retrieveHighScoreCompletionEscapingResultIntManabuErrorVoidVoidClosure?(completion)
    }

    //MARK: - saveHighScores

    var saveHighScoresHighScoreIntManabuErrorCallsCount = 0
    var saveHighScoresHighScoreIntManabuErrorCalled: Bool {
        return saveHighScoresHighScoreIntManabuErrorCallsCount > 0
    }
    var saveHighScoresHighScoreIntManabuErrorReceivedHighScore: (Int)?
    var saveHighScoresHighScoreIntManabuErrorReceivedInvocations: [(Int)] = []
    var saveHighScoresHighScoreIntManabuErrorReturnValue: ManabuError?
    var saveHighScoresHighScoreIntManabuErrorClosure: ((Int) -> ManabuError?)?

    func saveHighScores(highScore: Int) -> ManabuError? {
        saveHighScoresHighScoreIntManabuErrorCallsCount += 1
        saveHighScoresHighScoreIntManabuErrorReceivedHighScore = highScore
        saveHighScoresHighScoreIntManabuErrorReceivedInvocations.append(highScore)
        if let saveHighScoresHighScoreIntManabuErrorClosure = saveHighScoresHighScoreIntManabuErrorClosure {
            return saveHighScoresHighScoreIntManabuErrorClosure(highScore)
        } else {
            return saveHighScoresHighScoreIntManabuErrorReturnValue
        }
    }


}
class PlayHomeViewModelProtocolMock: PlayHomeViewModelProtocol {




    //MARK: - fetchGames

    var fetchGamesCompletionEscapingGameModeVoidVoidCallsCount = 0
    var fetchGamesCompletionEscapingGameModeVoidVoidCalled: Bool {
        return fetchGamesCompletionEscapingGameModeVoidVoidCallsCount > 0
    }
    var fetchGamesCompletionEscapingGameModeVoidVoidReceivedCompletion: ((([GameMode]) -> Void))?
    var fetchGamesCompletionEscapingGameModeVoidVoidReceivedInvocations: [((([GameMode]) -> Void))] = []
    var fetchGamesCompletionEscapingGameModeVoidVoidClosure: ((@escaping ([GameMode]) -> Void) -> Void)?

    func fetchGames(completion: @escaping ([GameMode]) -> Void) {
        fetchGamesCompletionEscapingGameModeVoidVoidCallsCount += 1
        fetchGamesCompletionEscapingGameModeVoidVoidReceivedCompletion = completion
        fetchGamesCompletionEscapingGameModeVoidVoidReceivedInvocations.append(completion)
        fetchGamesCompletionEscapingGameModeVoidVoidClosure?(completion)
    }


}
public class TestProtocolMock: TestProtocol {

    public init() {}



    //MARK: - helloWorld

    public var helloWorldVoidCallsCount = 0
    public var helloWorldVoidCalled: Bool {
        return helloWorldVoidCallsCount > 0
    }
    public var helloWorldVoidClosure: (() -> Void)?

    public func helloWorld() {
        helloWorldVoidCallsCount += 1
        helloWorldVoidClosure?()
    }

    //MARK: - foo

    public var fooBarStringBoolCallsCount = 0
    public var fooBarStringBoolCalled: Bool {
        return fooBarStringBoolCallsCount > 0
    }
    public var fooBarStringBoolReceivedBar: (String)?
    public var fooBarStringBoolReceivedInvocations: [(String)] = []
    public var fooBarStringBoolReturnValue: Bool!
    public var fooBarStringBoolClosure: ((String) -> Bool)?

    public func foo(bar: String) -> Bool {
        fooBarStringBoolCallsCount += 1
        fooBarStringBoolReceivedBar = bar
        fooBarStringBoolReceivedInvocations.append(bar)
        if let fooBarStringBoolClosure = fooBarStringBoolClosure {
            return fooBarStringBoolClosure(bar)
        } else {
            return fooBarStringBoolReturnValue
        }
    }


}
