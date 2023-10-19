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
    
    case searchBooks(code: String)                                                    // GET
    case searchBooksPerPage(code: String, startIndex: String)                         // GET
    
    // MARK: - HTTPMethod
    
    private var method: HTTPMethod {
        switch self {
        case .searchBooks, .searchBooksPerPage
            : return .get
        }
    }
    
    // MARK: - Path
    
    private var path: String {
        switch self {
        case .searchBooks:
            return "/volumes?q=".appending(parameters?["code"] as! String)
            + "&key=\(token ?? "")"
            
        case .searchBooksPerPage:
            return "/volumes?q=".appending(parameters?["code"] as! String)
            + "&key=\(token ?? "")"
            + "&startIndex=".appending(parameters?["startIndex"] as! String)
            + "&maxResults=10"
        }
    }
    // MARK: - Parameters
    
    private var parameters: Parameters? {
        switch self {
        case .searchBooks(let code)
            : return ["code": code]
        case .searchBooksPerPage(let code, let startIndex)
            : return ["code": code, "startIndex": startIndex]
        }
    }
    
    // MARK: - Token
    
    private var token: String? {
        switch self {
        case .searchBooks, .searchBooksPerPage:
            let repo = TokenRepository()
            guard let token = repo.getFromDefaults() else { return nil }
            return token
        }
    }
    
    // MARK: - URLRequest
    
    func asURLRequest() throws -> URLRequest {
        var _url: URL?
        let baseUrl = "https://www.googleapis.com/books/v1".appending(path)
        
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
        
        switch self {
            /// whose has code in the url
        case .searchBooks, .searchBooksPerPage
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
