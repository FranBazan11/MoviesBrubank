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
}
