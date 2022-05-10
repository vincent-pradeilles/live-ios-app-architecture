//
//  MoviesViewModel.swift
//  AppArchitecture
//
//  Created by Vincent on 10/05/2022.
//

import Foundation

class MoviesViewModel {
    let movies: Variable<[Movie]> = Variable([])
    let error: Variable<Error?> = Variable(nil)

    func fetchData() {
        getMovies { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.movies.value = movieResponse.results
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}