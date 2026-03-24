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
    var reversingAllowed: Bool = false
    
    required init(syllabary: SyllabaryType, reversingAllowed: Bool = false) {
        self.syllabary = syllabary
        self.reversingAllowed = reversingAllowed
        self.currentCharacter = .init(japanese: "", english: "")
        
        super.init(frame: .zero)
        
        configure()
        setupTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ character: String) {
        currentCharacter?.japanese = character
        
        switch syllabary {
        case .hiragana:
            if let reverseCharacter = hiraganaDict[character] {
                currentCharacter?.english = reverseCharacter
            }
        case .katakana:
            if let reverseCharacter = katakanaDict[character] {
                currentCharacter?.english = reverseCharacter
            }
        case .romanji:
            print("XXX ROMANJI")
        }
        
        textLabel.text = character
    }
    
    @objc func reverse() {
        guard reversingAllowed else {
            return
        }
        
        if isReversed {
            textLabel.text = currentCharacter?.japanese
        } else {
            textLabel.text = currentCharacter?.english
        }

        isReversed.toggle()
    }
    
    func configure() {
        layer.cornerRadius = 50
        clipsToBounds = true
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .systemGray
        textLabel.backgroundColor = ColorPalette.paper
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 100, weight: .bold)

        
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
    
    enum Constants {
        static let textSize: CGFloat = 100
    }
}
