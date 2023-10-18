//
//  API.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit
import Alamofire

enum API: URLRequestConvertible {
    
    // MARK: - Properties
    
    case searchBooks(code: String)                                   // GET
    
    // MARK: - HTTPMethod
    
    private var method: HTTPMethod {
        switch self {
        case .searchBooks
            : return .get
        }
    }
    
    // MARK: - Path
    
    private var path: String {
        switch self {
        case .searchBooks:
            return "/volumes?q=".appending(parameters?["code"] as! String)
            + "&key=\(token ?? "")"
        }
    }
    // MARK: - Parameters
    
    private var parameters: Parameters? {
        switch self {
        case .searchBooks(let code)
            : return ["code": code]
        }
    }
    
    // MARK: - Token
    
    private var token: String? {
        switch self {
        case .searchBooks:
            let repo = TokenRepository()
            guard let token = repo.getFromDefaults() else { return nil }
            return token
        }
    }
    
    // MARK: - URLRequest
    
    func asURLRequest() throws -> URLRequest {
        var _url: URL?
        let baseUrl = "https://www.googleapis.com/books/v1".appending(path)
        //https://www.googleapis.com/books/v1/volumes?q=\(query)&key=\(apiKey)
        switch self {
        default:
            _url = URL(string: baseUrl)
        }
        
        guard let url = _url else {
            throw AFError.sessionInvalidated(error: nil)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue      /// HTTP Method
        urlRequest = try setupHeaders(urlRequest)    /// headers
        urlRequest = try setupParameters(urlRequest) /// Parameters
        return urlRequest
    }
    
    // MARK: - Setup Parameters
    
    private func setupParameters(_ request: URLRequest) throws -> URLRequest {
        let urlRequest = request
        /// if let parameters = parameters {
        switch self {
            /// whose has code in the url
        case .searchBooks
            : break
        }
        
        return urlRequest
    }
    
    // MARK: - Setup Headers
    
    private func setupHeaders(_ request: URLRequest) throws -> URLRequest {
        var urlRequest = request
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("", forHTTPHeaderField: "Authorization")
        if let token {
            urlRequest.addValue(token, forHTTPHeaderField: "Cookie")
        }
        return urlRequest
    }
    
}
