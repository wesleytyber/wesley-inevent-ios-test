//
//  OnboardingViewModel.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import Foundation

class OnboardingViewModel {
    
    let getOnboardingInfo: [OnboardingModel] = [
        OnboardingModel(name: "Bem-vindo ao meu teste técnico.",
                        image: "book-stack",
                        description: "Obrigado pela oportunidade."),
        OnboardingModel(name: "Vamos começar?",
                        image: "search",
                        description: "Pressione iniciar.")
    ]
    
    var count: Int {
        return getOnboardingInfo.count
    }
    
    func indexPath(indexPath: IndexPath) -> OnboardingModel {
        getOnboardingInfo[indexPath.row]
    }
    
}
