//
//  FlashcardView.swift
//  Manabu
//
//  Created by Luke on 11/03/2026.
//

import Foundation
import UIKit

class FlashcardView: UIView {
    var currentCharacter: CharacterPair?
    let syllabary: SyllabaryType
    
    var textLabel = UILabel()
    var isReversed: Bool = false
    
    required init(syllabary: SyllabaryType) {
        self.syllabary = syllabary
        self.currentCharacter = .init(japanese: "", english: "")
        
        super.init(frame: .zero)
        
        configure()
        setupTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ character: String, fontSize: CGFloat) {
        currentCharacter?.japanese = character
        
        switch syllabary {
        case .hiragana:
            if let reverseCharacter = hiraganaDict[character] {
                currentCharacter?.english = reverseCharacter
            }
        case .katakana:
            if let reverseCharacter = hiraganaDict[character] {
                currentCharacter?.english = reverseCharacter
            }
        }
        
        textLabel.text = character
        textLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    @objc func reverse() {
        if isReversed {
            textLabel.text = currentCharacter?.japanese
        } else {
            textLabel.text = currentCharacter?.english
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

extension FlashcardView {
    struct CharacterPair {
        var japanese: String
        var english: String
    }
}
