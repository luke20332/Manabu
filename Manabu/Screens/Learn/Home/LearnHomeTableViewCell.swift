//
//  LearnHomeTableViewCell.swift
//  Manabu
//
//  Created by Luke on 10/03/2026.
//

import UIKit

class LearnHomeTableViewCell: UITableViewCell {
    var textImageView = UILabel()
    var titleLabel = UILabel()
    var charactersSeenLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(textImageView)
        addSubview(titleLabel)
        addSubview(charactersSeenLabel)
        
        configureTextImageView()
        configureTitleLabel()
        configureCharactersSeenLabel()
        
        setTextImageConstraints()
        setTitleLabelConstraints()
        setCharactersSeenLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(syllabary: Syllabary) {
        self.backgroundColor = ColorPalette.backgroundColor
        
        textImageView.text = syllabary.image
        
        titleLabel.text = syllabary.title
        charactersSeenLabel.text = "\(syllabary.charactersSeen) / 100 Characters Seen"
    }
    
    func configureTextImageView() {
        textImageView.textAlignment = .center
        textImageView.font = .systemFont(ofSize: 60, weight: .semibold)
        textImageView.textColor = .label
        textImageView.adjustsFontForContentSizeCategory = true
    }
    
    func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    
    func configureCharactersSeenLabel() {
        charactersSeenLabel.numberOfLines = 0
        charactersSeenLabel.adjustsFontSizeToFitWidth = true
        charactersSeenLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    func setTextImageConstraints() {
        textImageView.translatesAutoresizingMaskIntoConstraints = false
        textImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        textImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        textImageView.widthAnchor.constraint(equalTo: textImageView.heightAnchor).isActive = true
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: textImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setCharactersSeenLabelConstraints() {
        charactersSeenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            charactersSeenLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            charactersSeenLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            charactersSeenLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

