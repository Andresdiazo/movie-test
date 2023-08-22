//
//  PopularMovieInteractor.swift
//  TMDB-test
//
//  Created by Andres Diaz  on 11/05/23.
//

import Foundation
import UIKit

protocol PopularMovieInteractorDelegate: NSObject {
    func getResults(results: [Movies]?)
}

protocol PopularMovieProtocol {
    func setDelegate(delegate: PopularMovieInteractorDelegate)
}

class popularMoviesInteractor {
    weak var delegate: PopularMovieInteractorDelegate!
    let baseURL = "https://api.themoviedb.org/3/"
    let path = "/movie/popular"
    let apiKey = ""
    let headers = [ "accept": "application/json",
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NmU2ZDNjZTMwNGVhYTE1NDljZGQ2OTVkODM5ZWVmYiIsInN1YiI6IjVmOWUxNDE2YmM4YWJjMDAzOTMzYTg5NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.s0O8F--g_Ap0nw1zpKg9kA9JbeVZNuWQYGb45auxaMI"]
    func setDelegate(delegate: PopularMovieInteractorDelegate) {
        self.delegate = delegate
    }
}

extension popularMoviesInteractor: fecthDataProtocol, getBaseURLProtocol {
    
    func fetchData<T>(httpMethod: HTTPMethod, path: String, params: [String : Any]?, headers: [String : String]?, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let networkService = NetworkService(baseURL: baseURL)
        networkService.fecthData(httpMethod: .get, path: self.path, params: nil, headers: self.headers) { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let search):
                if !search.results.isEmpty && self.delegate != nil {
                    self.delegate.getResults(results: search.results)
                } else {
                    
                }
            case .failure(_):
                print("Hubo un error en la busqueda")
            }
        }
    }

    
    
    func getBaseUrl(path: String, parameters: [String : Any], headers: [String : String]?) -> URL? {
        <#code#>
    }
    
 
    
}



