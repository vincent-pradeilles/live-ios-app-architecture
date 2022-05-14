//
//  AppArchitectureTests.swift
//  AppArchitectureTests
//
//  Created by Vincent on 14/05/2022.
//

import XCTest
@testable import AppArchitecture

class AppArchitectureTests: XCTestCase {

    func testMoviesViewModel() {
        let mockedService = MoviesMockService()
        let viewModel = MoviesViewModel(service: mockedService)

        viewModel.fetchData()

        XCTAssertEqual(mockedService.getMoviesCallCount, 1)
        XCTAssertEqual(viewModel.movies.value.count, 3)
    }

    func testMovieDetailsViewModel() {
        let movie = Movie(id: 507086, title: "Jurassic World Dominion", overview: "Four years after Isla Nublar was destroyed, dinosaurs now live—and hunt—alongside humans all over the world. This fragile balance will reshape the future and determine, once and for all, whether human beings are to remain the apex predators on a planet they now share with history’s most fearsome creatures.", posterPath: "/w4c0GTpmEQ1CZQNHndTv2PPgf2p.jpg")
        let mockedService = MovieDetailsMockService()
        let viewModel = MovieDetailsViewModel(movie: movie, service: mockedService)

        viewModel.fetchData()

        XCTAssertEqual(mockedService.getCreditsCallCount, 1)
        XCTAssertEqual(mockedService.getCreditsMovieArgument, movie)
        XCTAssertEqual(viewModel.cast.value.count, 31)
    }
}
