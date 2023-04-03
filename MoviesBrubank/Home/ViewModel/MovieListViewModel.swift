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
        let moviesResponse: MovieList = try await RestClientServices.shared.fetch(urlString: Constants.baseListURL)
        let genresResponse: GenreList = try await RestClientServices.shared.fetch(urlString: Constants.baseGenreURL)
        
        var moviesModel: [MovieModel] = []
        for movie in moviesResponse.results {
            let image = try await loaderImage.fetchImage(with: movie.backdropPath)
            if let genre = genresResponse.genres.first(where: { $0.id == movie.genreIds.first }) {
                let movieModel = MovieModel(movie: movie, image: image, genre: genre.name)
                moviesModel.append(movieModel)
            }
        }
        return moviesModel
    }
}
