//
//  OnboardingViewModel.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import Foundation

class OnboardingViewModel {
    
    var onboardingModel: [OnboardingModel] = []
    
    func getOnboardingInfo() {
        onboardingModel.append(contentsOf: [
            OnboardingModel(name: "Bem-vindo ao meu teste técnico.",
                            image: "books.vertical.fill",
                            description: "Obrigado pela oportunidade."),
            OnboardingModel(name: "Vamos começar?",
                            image: "books.vertical.fill",
                            description: "Pressione iniciar.")
        ])
    }
    
    var count: Int {
        return onboardingModel.count
    }
    
    func indexPath(indexPath: IndexPath) -> OnboardingModel {
        onboardingModel[indexPath.row]
    }
    
}
