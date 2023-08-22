//
//  NetworkService.swift
//  TMDB-test
//
//  Created by Andres Diaz  on 19/07/23.

import Foundation
import UIKit

protocol getBaseURLProtocol {
    
    func getBaseUrl(path: String,
                    parameters: [String: Any],
                    headers: [String: String]? ) -> URL?
}

protocol fecthDataProtocol {
    func fetchData<T: Decodable>(httpMethod: HTTPMethod,
                                 path: String,
                                 params: [String: Any]?,
                                 headers: [String: String]?,
                                 completionHandler: @escaping (Result<T, Error>) -> Void)
}


class NetworkService {
    
    var baseURL : URL?
    init (baseURL: String) {
        self.baseURL = URL(string: baseURL)
    }
    
    func getBaseUrl(path: String, parameters: [String: Any] = [:]) -> URL? {
        guard let baseURL = baseURL?.appendingPathComponent(path) else { return nil }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0, value: String(describing: $1))
            }
        }
        let url = URL(string: urlComponents.url?.absoluteString.removingPercentEncoding ?? "")
        return url
    }
    
    func fecthData<T: Decodable>(httpMethod: HTTPMethod,
                                 path: String,
                                 params: [String: Any]? = nil,
                                 headers: [String: String]? = nil,
                                 completionHandler: @escaping (Result<T, Error>) -> Void) {
        var url: URL?
        var httpBody: Data?
        
        if let params = params {
            if httpMethod != .get {
                let body = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                httpBody = body
                url = self.getBaseUrl(path: path)
            } else {
                url = self.getBaseUrl(path: path, parameters: params)
            }
        } else {
            url = getBaseUrl(path: path)
        }
        
        guard let requestUrl: URL = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpBody = httpBody
        request.httpMethod = httpMethod.rawValue
        
        if let headers = headers {
            for (field, value) in headers {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let responseData = try? JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(responseData!))
                
            } else if let error = error {
                print("Error: \(error)")
                completionHandler(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Respuesta inválida del servidor")
                return
            }
        }
        task.resume()
    }
}
