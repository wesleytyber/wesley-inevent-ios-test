//
//  BooksService.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit
import ServiceKit

class BooksService {
    
    func searchBooks(with string: String, completion: @escaping ([ModelBooks]?, NetworkError?) -> Void) {
        Repository.manager.request(API.searchBooks(code: string)).response { response in
            guard let data = response.data else { completion(nil, nil) ; return }
            NetworkLogger.log(request: response.request, response: response.response, data: data, error: response.error)
            
            do {
                let res: [ModelBooks] = try data.decoded()
                completion(res, nil)
                
            } catch let error {
                completion(nil, NetworkError.decodingError(error))
            }
        }
    }
    
}
