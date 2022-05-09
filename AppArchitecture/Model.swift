//
//  Model.swift
//  AppArchitecture
//
//  Created by Vincent on 09/05/2022.
//

import Foundation
import UIKit

let apiKey = "da9bc8815fb0fc31d5ef6b3da097a009"

/* Movies */

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

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

func getMovies(_ completion: @escaping (MovieResponse?, Error?) -> Void) {
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!

    URLSession.shared.dataTask(with: url) { data, _, error in
        guard error == nil else {
            completion(nil, error)
            return
        }

        let decoded = try! jsonDecoder.decode(MovieResponse.self, from: data!)

        completion(decoded, nil)
    }.resume()
}

func getPoster(for movie: Movie, _ completion: @escaping (UIImage?, Error?) -> Void) {
    URLSession.shared.dataTask(with: movie.posterURL) { data, _, error in
        guard error == nil else {
            completion(nil, error)
            return
        }

        let decoded = UIImage(data: data!)
        completion(decoded, nil)
    }.resume()
}

/* Movie Credits */

struct MovieCastMember: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let character: String
}

struct MovieCreditsResponse: Decodable {
    let cast: [MovieCastMember]
}

func getCredits(for movie: Movie, _ completion: @escaping (MovieCreditsResponse?, Error?) -> Void) {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)")!

    URLSession.shared.dataTask(with: url) { data, _, error in
        guard error == nil else {
            completion(nil, error)
            return
        }

        let decoded = try! jsonDecoder.decode(MovieCreditsResponse.self, from: data!)

        completion(decoded, nil)
    }.resume()
}
