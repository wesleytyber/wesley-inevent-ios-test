//
//  OnboardingviewCellModel.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import UIKit

class OnboardingCellViewModel {
    
    var onboardingModel: OnboardingModel?
    
    init(onboardingModel: OnboardingModel? = nil) {
        self.onboardingModel = onboardingModel
    }
    
    var primaryLabel: String {
        return onboardingModel?.name ?? ""
    }
    
    var secondaryLabel: String {
        return onboardingModel?.description ?? ""
    }
    
    var imageString: String {
        return onboardingModel?.image ?? ""
    }
}
