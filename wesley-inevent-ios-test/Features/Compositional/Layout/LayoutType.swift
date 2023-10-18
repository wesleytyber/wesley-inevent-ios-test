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
    
    func getLayout(withHeader: Bool = true) -> NSCollectionLayoutSection {
        switch self {
            
        case .reusable:
            return AppLayout.shared.reusable(withHeader: true)
            
        case .footer:
            return AppLayout.shared.footer(withFooter: true)
            
        case .normal:
            return AppLayout.shared.normal()
        }
    }
}
