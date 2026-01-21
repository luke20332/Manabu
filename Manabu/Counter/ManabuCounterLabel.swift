//
//  ManabuCounterLabel.swift
//  Manabu
//
//  Created by Luke on 20/01/2026.
//

import UIKit

class ManabuCounterLabel: UILabel {
    
    var count: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func increment() {
        count += 1
        text = "Streak: \(count)"
    }
    
    func reset() {
        count = 0
        isHidden = true
    }
}
