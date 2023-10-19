//
//  UIButton+Ext.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import UIKit

extension UIButton {
    
    enum ButtonStyleAppearance {
        case primary
    }
    
    func setButtonDesign(layout: ButtonStyleAppearance) {
        switch layout {
            
        case .primary:
            translatesAutoresizingMaskIntoConstraints = false
            tintColor = .white
            backgroundColor = .systemPink
            layer.cornerRadius = 8
            layer.masksToBounds = false
            setTitleColor(.white, for: .normal)
        }
    }
}
