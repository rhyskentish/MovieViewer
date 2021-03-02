//
//  ContentView.swift
//  MovieViewer
//
//  Created by Rhys Kentish on 02/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = MovieListViewModel()
    
    var body: some View {
        List(viewModel.movies) { movie in
            Text(movie.fullTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
