//
//  MovieViewModel.swift
//  MovieViewer
//
//  Created by Rhys Kentish on 02/03/2021.
//

import Foundation

class MovieViewModel: Identifiable {
    let id = UUID()
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var fullTitle: String {
        return self.movie.fullTitle
    }
    
    var rank: String {
        return self.movie.rank
    }
    
    var imageUrl: String {
        return self.movie.image
    }
    
    var crew: String {
        return self.movie.crew
    }
    
}
