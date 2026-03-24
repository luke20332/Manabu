//
//  ManabuHomeTranslationView.swift
//  Manabu
//
//  Created by Luke on 26/01/2026.
//

import Foundation
import UIKit

class ManabuHomeTranslationView: UIView {
    private let mainTextView: UIView = ManabuMainScriptView()
    private let secondaryTextView: UIView = ManabuTranslationInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureMainTextView()
        configureSecondaryTextView()
    }
    
    private func configureMainTextView() {
        addSubview(mainTextView)
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding),
            mainTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding),
            mainTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.padding),
            mainTextView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureSecondaryTextView() {
        addSubview(secondaryTextView)
        secondaryTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondaryTextView.topAnchor.constraint(equalTo: self.topAnchor),
            secondaryTextView.leadingAnchor.constraint(equalTo: mainTextView.trailingAnchor, constant: 30),
            secondaryTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            secondaryTextView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

private extension ManabuHomeTranslationView {
    enum Constants {
        static let padding: CGFloat = 5
    }
}

enum PartOfSpeech {
    case noun
    case pronoun
    case verb
    case adverb
    case adjective
    case preposition
    case conjunction
    case interjection
}
