//
//  ViewControllerProvider.swift
//  AppArchitecture
//
//  Created by Vincent on 10/05/2022.
//

import Foundation
import UIKit

enum ViewControllerProvider {
    static var moviesViewController: MoviesViewController {
        let service = MoviesService()
        let viewModel = MoviesViewModel(service: service)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesList") as! MoviesViewController
        viewController.viewModel = viewModel
        return viewController
    }

    static func movieDetailsController(for movie: Movie) -> MovieDetailsViewController {
        let service = MovieDetailsService()
        let viewModel = MovieDetailsViewModel(movie: movie,service: service)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetailsViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
