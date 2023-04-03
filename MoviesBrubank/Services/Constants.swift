//
//  Constants.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 26/03/2023.
//

import Foundation

enum Constants {
    static let apiKey = "api_key=208ca80d1e219453796a7f9792d16776"
    static let baseListURL = "https://api.themoviedb.org/4/list/1?\(apiKey)"
    static let baseGenreURL = "https://api.themoviedb.org/3/genre/movie/list?\(apiKey)"
    static let baseImageURL = "https://image.tmdb.org/t/p/original"
}
