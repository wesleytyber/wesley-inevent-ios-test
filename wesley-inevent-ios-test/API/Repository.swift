//
//  Repository.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import Foundation
import Alamofire

class Repository {
    
    static let manager: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 0
        config.timeoutIntervalForResource = 0
        return Alamofire.Session(configuration: config)
    }()
    
}
