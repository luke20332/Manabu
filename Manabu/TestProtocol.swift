//
//  TestProtocol.swift
//  Manabu
//
//  Created by Luke on 28/01/2026.
//

import Foundation

// sourcery: AutoMockable
public protocol TestProtocol: AnyObject {
    func helloWorld()
    
    func foo(bar: String) -> Bool
}
