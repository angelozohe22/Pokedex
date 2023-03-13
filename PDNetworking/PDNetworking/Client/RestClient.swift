//
//  RestClient.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public protocol RestClientProtocol {
    
    func request<AnyRequest: BaseRequest>(_ request: AnyRequest, parameters: [String:String]?, completion: @escaping (Result<AnyRequest.Response, NetworkingError>) -> Void)
    
}

public class RestClient: RestClientProtocol {
    
    // MARK: - Properties
    
    static let shared = RestClient()
    
    public let urlSession: URLSession
    
    private var searchTask: URLSessionDataTask?
    
    // MARK: - Lifecycle
    
    private init() {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.timeoutIntervalForRequest = 30
        urlSessionConfiguration.timeoutIntervalForResource = 30
        urlSession = URLSession(configuration: urlSessionConfiguration)
    }
    
    // MARK: - Functions
    
    public func searchRequest<AnyRequest: BaseRequest>(_ request: AnyRequest, parameters: [String:String]? = nil, completion: @escaping (Result<AnyRequest.Response, NetworkingError>) -> Void) {
        
        searchTask?.cancel()
        
        guard let url = URL(request: request),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return completion(.failure(.invalidRequestError("Invalid URL: \(request.baseURL) \(request.service) \(request.path)")))
        }
        
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            parameters.forEach {
                let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
                queryItems.append(urlQueryItem)
            }
            urlComponents.queryItems = queryItems
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.rawValue
        
        let headers = Dictionary(uniqueKeysWithValues: request.headers.map { key, value in (key.rawValue, value) })
        urlRequest.allHTTPHeaderFields = headers
        
        if !PDNetworkReachability.shared.isConnected {
            completion(.failure(.notConnectionInternet))
        } else {
            let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    return completion(.failure(.unexpectedError(error)))
                }
                
                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    return completion(.failure(.invalidResponse))
                }
                
                switch response.statusCode {
                case 401:
                    completion(.failure(.unauthorized))
                default:
                    completion(.failure(.invalidResponse))
                    break
                }

                guard let data = data else {
                    return completion(.failure(.noContent))
                }

                do {
                    try completion(.success(request.decode(data)))
                } catch let error {
                    completion(.failure(.parsingError(error, "Failed parsing object")))
                }
            }
            
            searchTask = task
            searchTask?.resume()
        }
    }
    
    public func request<AnyRequest: BaseRequest>(_ request: AnyRequest, parameters: [String:String]? = nil, completion: @escaping (Result<AnyRequest.Response, NetworkingError>) -> Void) {
        
        guard let url = URL(request: request),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return completion(.failure(.invalidRequestError("Invalid URL: \(request.baseURL) \(request.service) \(request.path)")))
        }
        
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            parameters.forEach {
                let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
                queryItems.append(urlQueryItem)
            }
            urlComponents.queryItems = queryItems
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.rawValue
        
        let headers = Dictionary(uniqueKeysWithValues: request.headers.map { key, value in (key.rawValue, value) })
        urlRequest.allHTTPHeaderFields = headers
        
        if !PDNetworkReachability.shared.isConnected {
            completion(.failure(.notConnectionInternet))
        }else {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    return completion(.failure(.unexpectedError(error)))
                }
                
                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    return completion(.failure(.invalidResponse))
                }
                
                switch response.statusCode {
                case 401:
                    completion(.failure(.unauthorized))
                default:
                    completion(.failure(.invalidResponse))
                    break
                }

                guard let data = data else {
                    return completion(.failure(.noContent))
                }

                do {
                    try completion(.success(request.decode(data)))
                } catch let error {
                    completion(.failure(.parsingError(error, "Failed parsing object")))
                }
            }
            .resume()
        }
    }
    
}
