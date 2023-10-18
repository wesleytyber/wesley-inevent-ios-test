//
//  ViewController.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 14/10/23.
//

import UIKit

class HomeController: UIViewController {
    
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

}

extension HomeController: Controller {
    
    func configureRequets() {
        
    }
    
    func configureDelegates() {
        
    }
    
    func configureCompositionalLayout() { }
    
    func configureAdditionalBehaviors() { }
    
}
