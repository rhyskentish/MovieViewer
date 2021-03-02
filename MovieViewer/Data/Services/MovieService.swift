//
//  MovieService.swift
//  MovieViewer
//
//  Created by Rhys Kentish on 02/03/2021.
//

import Foundation

let baseURL = "https://imdb-api.com/en/API/Top250Movies/k_x3hy019r"

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case noData
}

class MovieService {
    func getAllMovies(url: String = baseURL, completion: @escaping (Result<MovieResponse, NetworkError>) -> ()) {
        guard let apiUrl = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) {
            data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            print(data)
            
            let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
            if let movieResponse = movieResponse {
                DispatchQueue.main.async {
                    completion(.success(movieResponse))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
