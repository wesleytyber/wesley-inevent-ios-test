//
//  ConfigureController.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import Foundation

public protocol Controller {
    func configureRequets()
    func configureDelegates()
    func configureCompositionalLayout()
    func configureAdditionalBehaviors()
}

extension Controller {
    func initController() {
        configureRequets()
        configureDelegates()
        configureCompositionalLayout()
        configureAdditionalBehaviors()
    }
}
