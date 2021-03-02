//
//  MovieListViewModel.swift
//  MovieViewer
//
//  Created by Rhys Kentish on 02/03/2021.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    init() {
        fetchAllMovies()
    }
    
    @Published var movies = [MovieViewModel]()
    
    @Published var error: String?
    
    private func fetchAllMovies() {
        MovieService().getAllMovies { (result) in
            switch result {
                case .success(let movieResponse):
                    self.movies = movieResponse.items.map({ (movie) -> MovieViewModel in
                        return MovieViewModel.init(movie: movie)
                    })
                case .failure(let error):
                    self.error = error.localizedDescription
            }
        }
    }
    
}
