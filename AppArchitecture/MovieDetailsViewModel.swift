//
//  MovieDetailsViewModel.swift
//  AppArchitecture
//
//  Created by Vincent on 10/05/2022.
//

import Foundation
import UIKit

class MovieDetailsViewModel {

    let movie: Movie

    let poster: Variable<UIImage?> = Variable(nil)
    let cast: Variable<[MovieCastMember]> = Variable([])
    let error: Variable<Error?> = Variable(nil)

    private let service: MovieDetailsServicing

    init(movie: Movie, service: MovieDetailsServicing) {
        self.movie = movie
        self.service = service
    }

    func fetchData() {
        service.getPoster(for: movie) { [weak self] result in
            switch result {
            case .success(let poster):
                self?.poster.value = poster
            case .failure(let error):
                self?.error.value = error
            }
        }

        service.getCredits(for: movie) { [weak self] result in
            switch result {
            case .success(let creditsResponse):
                self?.cast.value = creditsResponse.cast
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}
