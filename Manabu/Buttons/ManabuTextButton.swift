//
//  ManabuTextButton.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit

class ManabuTextButton: UIButton {
    
    var text: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: .zero)
        set(title: title, color: color)
    }
    
    private func configure() {
        configuration = .tinted()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    final func set(title: String, color: UIColor) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .label
        configuration?.title = title
        
        text = title
    }
}
