//
//  Movie.swift
//

import Foundation
import UIKit

struct Movie: Codable, Hashable {
    let id: Int
    let overview: String
    let releaseDate: String
    let title: String
    let backdropPath: String
    let posterPath: String
    let genreIds: [Int]
}

struct MovieModel: Hashable {
    let movie: Movie
    let image: UIImage
}
