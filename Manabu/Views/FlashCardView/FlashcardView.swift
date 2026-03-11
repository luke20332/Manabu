//
//  FlashcardView.swift
//  Manabu
//
//  Created by Luke on 11/03/2026.
//

import Foundation
import UIKit

class FlashcardView: UIView {
    var currentCharacter: (String, String)?
    let syllabary: SyllabaryType
    
    var textLabel = UILabel()
    var isReversed: Bool = false
    
    required init(syllabary: SyllabaryType) {
        self.syllabary = syllabary
        super.init(frame: .zero)
        configure()
        setupTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ character: String, fontSize: CGFloat) {
        currentCharacter?.0 = character
        switch syllabary {
        case .hiragana:
            currentCharacter?.1 = hiraganaDict[character]!
        case .katakana:
            currentCharacter?.1 = katakanaDict[character]!
        }
        textLabel.text = character
        textLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    @objc func reverse() {
        if isReversed {
            textLabel.text = currentCharacter?.0
        } else {
            textLabel.text = currentCharacter?.1
        }
        
        isReversed.toggle()
    }
    
    func configure() {
        textLabel.layer.cornerRadius = 50
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .systemBackground
        textLabel.backgroundColor = .label
        textLabel.textAlignment = .center
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reverse))
        
        self.addGestureRecognizer(tapGesture)
    }
    
    func setupTextLabel() {
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
