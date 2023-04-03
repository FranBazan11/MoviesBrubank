//
//  DownloadAsyncImageLoader.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 03/04/2023.
//

import Foundation
import UIKit
class DownloadAsyncImageLoader {
    func fetchImage(with path: String) async throws -> UIImage {
        guard let url = URL(string: Constants.baseImageURL + path) else {
            throw HttpError.badURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data) ?? UIImage()
    }
}
