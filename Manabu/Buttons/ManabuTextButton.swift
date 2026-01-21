//
//  ManabuTextButton.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit

class ManabuTextButton: UIButton {
    private var defaultFontSize: CGFloat = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, color: UIColor, fontSize: CGFloat, systemImageName: String) {
        self.init(frame: .zero)
        set(title: title, color: color, fontSize: fontSize, systemImageName: systemImageName)
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
    
    final func set(title: String, color: UIColor, fontSize: CGFloat, systemImageName: String?) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .label
        configuration?.title = title
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)

        guard let systemImageName else {
            return
        }
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
    
    final func setColor(_ color: UIColor) {
        configuration?.baseBackgroundColor = color
    }
}
