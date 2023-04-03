//
//  MovieListViewModel.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 26/03/2023.
//

import Foundation
import UIKit


class MovieListViewModel {
    let loaderImage = DownloadAsyncImageLoader()
    
    func fetchMovies() async throws -> [MovieModel] {
        let moviesResponse: MovieList = try await RestClientServices.shared.fetch(urlString: Constants.baseURL)
        var moviesModel: [MovieModel] = []
        for movie in moviesResponse.results {
            let image = try await loaderImage.fetchImage(with: movie.backdropPath)
            let movieModel = MovieModel(movie: movie, image: image)
            moviesModel.append(movieModel)
        }
        return moviesModel
    }
}
