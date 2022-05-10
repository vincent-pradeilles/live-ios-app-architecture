//
//  MovieDetailsViewModel.swift
//  AppArchitecture
//
//  Created by Vincent on 10/05/2022.
//

import Foundation
import UIKit

class MovieDetailsViewModel {

    var movie: Movie!

    let poster: Variable<UIImage?> = Variable(nil)
    let cast: Variable<[MovieCastMember]> = Variable([])
    let error: Variable<Error?> = Variable(nil)

    func fetchData() {
        guard let movie = movie else {
            return
        }

        getPoster(for: movie) { [weak self] result in
            switch result {
            case .success(let poster):
                self?.poster.value = poster
            case .failure(let error):
                self?.error.value = error
            }
        }

        getCredits(for: movie) { [weak self] result in
            switch result {
            case .success(let creditsResponse):
                self?.cast.value = creditsResponse.cast
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}
