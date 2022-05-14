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

class MovieDetailsMockService: MovieDetailsServicing {
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        let poster = UIImage(named: "mock_poster")!

        completion(.success(poster))
    }

    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void) {
        let response = MovieCreditsResponse(cast: [
            MovieCastMember(id: 4783, name: "Sam Neill", character: "Dr. Alan Grant"),
            MovieCastMember(id: 4784, name: "Laura Dern", character: "Dr. Ellie Sattler"),
            MovieCastMember(id: 4785, name: "Jeff Goldblum", character: "Dr. Ian Malcolm"),
            MovieCastMember(id: 73457, name: "Chris Pratt", character: "Owen Grady"),
            MovieCastMember(id: 18997, name: "Bryce Dallas Howard", character: "Claire Dearing"),
            MovieCastMember(id: 1639848, name: "Mamoudou Athie", character: "Ramsay Cole"),
            MovieCastMember(id: 87954, name: "Scott Haze", character: ""),
            MovieCastMember(id: 94797, name: "Dichen Lachman", character: ""),
            MovieCastMember(id: 1257819, name: "Daniella Pineda", character: "Zia Rodriguez"),
            MovieCastMember(id: 2058708, name: "Isabella Sermon", character: "Maisie Lockwood"),
            MovieCastMember(id: 1029934, name: "Justice Smith", character: "Franklin Webb"),
            MovieCastMember(id: 78423, name: "Omar Sy", character: "Barry Sembène"),
            MovieCastMember(id: 206425, name: "DeWanda Wise", character: ""),
            MovieCastMember(id: 55152, name: "Campbell Scott", character: "Lewis Dodgson"),
            MovieCastMember(id: 14592, name: "BD Wong", character: "Dr. Henry Wu"),
            MovieCastMember(id: 3126155, name: "Joel Elferink", character: ""),
            MovieCastMember(id: 543505, name: "Jake Johnson", character: "Lowery Cruthers"),
            MovieCastMember(id: 159386, name: "Kristoffer Polaha", character: "Wyatt Huntley"),
            MovieCastMember(id: 1490863, name: "Elva Trill", character: "Charlotte Lockwood"),
            MovieCastMember(id: 3107735, name: "Lillia Langley", character: "Drive in Movie Theatre Kid"),
            MovieCastMember(id: 129984, name: "Glynis Davies", character: "Carolyn O\'Hara"),
            MovieCastMember(id: 1566387, name: "Dimitri Vegas", character: ""),
            MovieCastMember(id: 3144882, name: "Adam Kiani", character: "Security Guard"),
            MovieCastMember(id: 71073, name: "Enzo Squillino Jr.", character: ""),
            MovieCastMember(id: 3144892, name: "Bastian Antonio Fuentes", character: "Ramon"),
            MovieCastMember(id: 1655621, name: "Bernardo Santos", character: "Biosyn Scientist"),
            MovieCastMember(id: 3144894, name: "Ross Donnelly", character: "Washington Pedestrian"),
            MovieCastMember(id: 3144896, name: "Manuela Mora", character: "Alicia"),
            MovieCastMember(id: 3144901, name: "Teresa Cendon-Garcia", character: "Farmer"),
            MovieCastMember(id: 3041319, name: "Metin Hassan", character: "Maltese Gangster"),
            MovieCastMember(id: 950125, name: "Cokey Falkow", character: "Hunter")
        ])

        completion(.success(response))
    }
}
