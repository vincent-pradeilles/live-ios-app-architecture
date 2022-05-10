//
//  MoviesService.swift
//  AppArchitecture
//
//  Created by Vincent on 10/05/2022.
//

import Foundation

struct Movie: Decodable, Equatable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    var posterURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath)")!
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

protocol MoviesServicing {
    func getMovies(_ completion: @escaping (Result<MovieResponse, Error>) -> Void)
}

class MoviesService: MoviesServicing {
    func getMovies(_ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            let decoded = try! jsonDecoder.decode(MovieResponse.self, from: data!)

            completion(.success(decoded))
        }.resume()
    }
}
