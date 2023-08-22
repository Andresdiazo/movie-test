//
//  PopularPresenter.swift
//  TMDB-test
//
//  Created by Andres Diaz  on 18/07/23.
//

import Foundation

class ListofMoviesPresenter {
    private let listOfMovieInteractor: NetworkService
    
    init(listOfMovieInteractor: NetworkService = NetworkService(baseURL: "")) {
        self.listOfMovieInteractor = listOfMovieInteractor
    }
    
    func onViewAppear() {
        Task {
            let models = await listOfMovieInteractor.fecthData(httpMethod: .get, path: String, completionHandler: <#T##(Result<Decodable, Error>) -> Void#>)
        }
    }
}

