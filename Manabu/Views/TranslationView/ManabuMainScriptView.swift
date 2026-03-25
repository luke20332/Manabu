//
//  ManabuMainScriptView.swift
//  Manabu
//
//  Created by Luke on 26/01/2026.
//

import Foundation
import UIKit

class ManabuMainScriptView: UIView {
    private var stackView = UIStackView()
    private var hiraganaText = UILabel()
    private var kanjiText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(hiragana: String, kanji: String) {
        hiraganaText.text = hiragana
        kanjiText.text = kanji
    }
    
    private func configure() {
        addSubview(stackView)
        configureStackView()
        configureHiraganaText()
        configureKanjiText()
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        stackView.addArrangedSubview(hiraganaText)
        stackView.addArrangedSubview(kanjiText)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func configureHiraganaText() {
        hiraganaText.text = "まな"
        hiraganaText.textColor = .systemGray
        hiraganaText.font = .systemFont(ofSize: 12)
        hiraganaText.lineBreakMode = .byTruncatingTail
        hiraganaText.minimumScaleFactor = 0.9
        hiraganaText.adjustsFontSizeToFitWidth = true
    }
    
    private func configureKanjiText() {
        kanjiText.text = "学ぶ"
        kanjiText.textColor = .systemGray
        kanjiText.font = .systemFont(ofSize: 35)
        kanjiText.lineBreakMode = .byTruncatingTail
        kanjiText.minimumScaleFactor = 0.9
        kanjiText.adjustsFontSizeToFitWidth = true
    }
}
