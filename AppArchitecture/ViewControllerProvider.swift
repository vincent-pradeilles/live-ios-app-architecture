//
//  ViewControllerProvider.swift
//  AppArchitecture
//
//  Created by Vincent on 10/05/2022.
//

import Foundation
import UIKit

enum AppConfiguration {
    case live
    case mock
}

let appConfiguration: AppConfiguration = .live

enum ViewControllerProvider {
    static var moviesViewController: MoviesViewController {
        let service: MoviesServicing
        switch appConfiguration {
        case .live:
            service = MoviesService()
        case .mock:
            service = MoviesMockService()
        }
        let viewModel = MoviesViewModel(service: service)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesList") as! MoviesViewController
        viewController.viewModel = viewModel
        return viewController
    }

    static func movieDetailsController(for movie: Movie) -> MovieDetailsViewController {
        let service: MovieDetailsServicing
        switch appConfiguration {
        case .live:
            service = MovieDetailsService()
        case .mock:
            service = MovieDetailsMockService()
        }
        let viewModel = MovieDetailsViewModel(movie: movie,service: service)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetailsViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
