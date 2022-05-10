//
//  MovieDetailsService.swift
//  AppArchitecture
//
//  Created by Vincent on 10/05/2022.
//

import UIKit

enum ImageError: Error {
    case couldNotDecode
}

struct MovieCastMember: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let character: String
}

struct MovieCreditsResponse: Decodable {
    let cast: [MovieCastMember]
}

protocol MovieDetailsServicing {
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage, Error>) -> Void)
    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void)
}

class MovieDetailsService: MovieDetailsServicing {
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: movie.posterURL) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let decoded = UIImage(data: data!) else {
                completion(.failure(ImageError.couldNotDecode))
                return
            }

            completion(.success(decoded))
        }.resume()
    }

    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            let decoded = try! jsonDecoder.decode(MovieCreditsResponse.self, from: data!)

            completion(.success(decoded))
        }.resume()
    }
}
