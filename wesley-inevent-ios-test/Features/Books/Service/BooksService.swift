//
//  BooksService.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit
import ServiceKit

class BooksService {
    
    func searchBooks(with string: String, completion: @escaping (ModelBooks?, NetworkError?) -> Void) {
        Repository.manager.request(API.searchBooks(code: string)).response { response in
            guard let data = response.data else { completion(nil, nil) ; return }
            NetworkLogger.log(request: response.request, response: response.response, data: data, error: response.error)
            
            do {
                let res: ModelBooks = try data.decoded()
                completion(res, nil)
                
            } catch let error {
                completion(nil, NetworkError.decodingError(error))
            }
        }
    }
    
    func fetchBooksPage(with search: String, startIndex: Int, pageSize: Int, completion: @escaping (Result<ModelBooks, Error>) -> Void) {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(search)&key=\(TokenRepository().getFromDefaults() ?? "")&startIndex=\(startIndex)&maxResults=\(pageSize)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ModelBooks.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
