//
//  MovieDetailsViewController.swift
//  AppArchitecture
//
//  Created by Vincent on 09/05/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var movie: Movie!

    var cast: [MovieCastMember] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = movie.title
        overviewLabel.text = movie.overview

        getPoster(for: movie) { [weak self] poster, _ in
            guard let poster = poster else {
                return
            }

            DispatchQueue.main.async {
                self?.posterImageView.image = poster
            }
        }

        tableView.dataSource = self

        getCredits(for: movie) { [weak self] creditsResponse, _ in
            guard let creditsResponse = creditsResponse else {
                return
            }

            DispatchQueue.main.async {
                self?.cast = creditsResponse.cast
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCast", for: indexPath)
        let castMember = cast[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = castMember.name
        content.textProperties.font = .preferredFont(forTextStyle: .headline)
        content.secondaryText = castMember.character
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = content

        return cell
    }
}