//
//  MainCoordinator.swift
//  AppArchitecture
//
//  Created by Vincent on 14/05/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewControllerProvider.moviesViewController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func displayDetails(of movie: Movie) {
        let detailsVC = ViewControllerProvider.movieDetailsController(for: movie)
        detailsVC.coordinator = self
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
