//
//  MovieDetailsViewController.swift
//  AppArchitecture
//
//  Created by Vincent on 09/05/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    weak var coordinator: MainCoordinator?

    var viewModel: MovieDetailsViewModel!

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var cast: [MovieCastMember] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.movie.title
        overviewLabel.text = viewModel.movie.overview

        tableView.dataSource = self

        viewModel.poster.onUpdate = { [weak self] poster in
            self?.posterImageView.image = poster
        }

        viewModel.cast.onUpdate = { [weak self] _ in
            self?.tableView.reloadData()
        }

        viewModel.fetchData()
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cast.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCast", for: indexPath)
        let castMember = viewModel.cast.value[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = castMember.name
        content.textProperties.font = .preferredFont(forTextStyle: .headline)
        content.secondaryText = castMember.character
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = content

        return cell
    }
}
