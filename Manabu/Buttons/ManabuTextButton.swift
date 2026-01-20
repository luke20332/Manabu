//
//  ManabuTextButton.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit

class ManabuTextButton: UIButton {
    
    var text: String?
    var isCorrect: Bool?
    
    private var defaultFontSize: CGFloat = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, color: UIColor, fontSize: CGFloat) {
        self.init(frame: .zero)
        set(title: title, color: color, fontSize: fontSize)
    }
    
    private func configure() {
        var config = UIButton.Configuration.tinted()
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: self.defaultFontSize, weight: .semibold)
            return outgoing
        }
        
        configuration = config
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    final func set(title: String, color: UIColor, fontSize: CGFloat) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .label
        configuration?.title = title
        
        text = title
    }
    
    final func setColor(_ color: UIColor) {
        configuration?.baseBackgroundColor = color
    }
}
