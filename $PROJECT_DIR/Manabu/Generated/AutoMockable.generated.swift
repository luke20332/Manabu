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


}
