//
//  RestClient.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public protocol RestClientProtocol {
    
    func request<AnyRequest: BaseRequest>(_ request: AnyRequest, parameters: [String:String]?, cancelPrevious: Bool, completion: @escaping (Result<AnyRequest.Response, NetworkingError>) -> Void)
    
}

public class RestClient: RestClientProtocol {
    
    // MARK: - Properties
    
    public static let shared = RestClient()
    
    private lazy var urlSession: URLSession = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.timeoutIntervalForRequest = 30
        urlSessionConfiguration.timeoutIntervalForResource = 30
        return URLSession(configuration: urlSessionConfiguration)
    }()
    
    private var performTask: URLSessionDataTask?
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Functions
    
    public func request<AnyRequest: BaseRequest>(_ request: AnyRequest, parameters: [String:String]? = nil, cancelPrevious: Bool = false, completion: @escaping (Result<AnyRequest.Response, NetworkingError>) -> Void) {
        
        if cancelPrevious {
            performTask?.cancel()
        }
        
        guard let url = URL(request: request),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return completion(.failure(.invalidRequestError("Invalid URL: \(request.baseURL)\(request.service)\(request.path)")))
        }
        
        if let parameters = parameters {
            let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            urlComponents.queryItems = queryItems
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.rawValue
        let headers = Dictionary(uniqueKeysWithValues: request.headers.map { key, value in (key.rawValue, value) })
        urlRequest.allHTTPHeaderFields = headers
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(.unexpectedError(error)))
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(.invalidResponse))
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    guard let data = data else {
                        return completion(.failure(.noContent))
                    }
                    do {
                        let decoded = try request.decode(data)
                        completion(.success(decoded))
                    } catch let error {
                        completion(.failure(.parsingError(error, "Failed parsing object")))
                    }
                case 401:
                    completion(.failure(.unauthorized))
                default:
                    completion(.failure(.invalidRequestError("Unexpected error")))
                }
            }
        }
        task.resume()
        if cancelPrevious {
            performTask = task
        }
    }
    
}
