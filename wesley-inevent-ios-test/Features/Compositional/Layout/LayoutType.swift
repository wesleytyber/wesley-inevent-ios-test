//
//  LayoutType.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit

enum LayoutType {
    case reusable
    case footer
    case normal
    
    func getLayout(withHeader: Bool = false) -> NSCollectionLayoutSection {
        switch self {
            
        case .reusable:
            return AppLayout.shared.reusable(withHeader: false)
            
        case .footer:
            return AppLayout.shared.footer(withFooter: false)
            
        case .normal:
            return AppLayout.shared.normal()
        }
    }
}
