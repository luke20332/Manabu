//
//  ManabuTranslationInfoView.swift
//  Manabu
//
//  Created by Luke on 27/01/2026.
//

import Foundation
import UIKit

class ManabuTranslationInfoView: UIView {
    private let stackView = UIStackView()
    private let pronounciationLabel = UILabel()
    private let translationOne = UILabel()
    private let translationTwo = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(stackView)
        configureStackView()
        configurePronounciation()
        configureTranslationView()
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(pronounciationLabel)
        stackView.addArrangedSubview(translationOne)
        stackView.addArrangedSubview(translationTwo)
        stackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configurePronounciation() {
        pronounciationLabel.text = "Manabu | Ma-na-bu | verb"
        pronounciationLabel.textColor = .systemGray
        pronounciationLabel.textAlignment = .left
        pronounciationLabel.numberOfLines = 0
    }
    
    private func configureTranslationView() {
        translationOne.text = "1. To Learn"
        translationTwo.text = "2. To Study"
        
        translationOne.textColor = .systemGray
        translationTwo.textColor = .systemGray
        
        translationOne.textAlignment = .left
        translationTwo.textAlignment = .left
        
        translationOne.numberOfLines = 0
        translationTwo.numberOfLines = 0
    }
}
