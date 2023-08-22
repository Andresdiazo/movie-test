//
//  SearchMoviePresenter.swift
//  TMDB-test
//
//  Created by Andres Diaz  on 11/05/23.
//

import Foundation
import UIKit

class popularMoviesPresenter {
    var array: [Movies]?
    var interactor: PopularMovieProtocol = popularMoviesInteractor()
    interactor.setDelegate(delegate: self)
}

extension popularMoviesPresenter: PopularMovieInteractorDelegate {
    func getResults(results: [Movies]?) {
        if let data = results {
            array = data
        }
    }
}
