//
//  RestClientServices.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 26/03/2023.
//

import Foundation
import UIKit

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

class RestClientServices {
    private init() {}
    
    static let shared = RestClientServices()
    
    func fetch<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let object = try? decoder.decode(T.self, from: data) else {
            throw HttpError.errorDecodingData
        }
        return object
    }
    
    
//    func fetchImage(with path: String) async throws -> UIImage? {
//        do {
//            if let url = URL(string: "https://image.tmdb.org/t/p/original" + path) {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                return UIImage(data: data)
//            }
//        } catch {
//            throw error
//        }
//    }
}


class DownloadAsyncImageLoader {
    func fetchImage(with path: String) async throws -> UIImage {
        guard let url = URL(string: "https://image.tmdb.org/t/p/original" + path) else {
            throw HttpError.badURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data) ?? UIImage()
    }
}
    

extension UIImage {
    /// Get image from URL.
    /// - returns: a completion block with UIImage.
    static func imageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            completion(image)
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, _ in
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode < 300,
                      let image = UIImage(data: data)
                else { return }
                let cachedData = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                DispatchQueue.main.async { completion(image) }
            }).resume()
        }
    }
}
