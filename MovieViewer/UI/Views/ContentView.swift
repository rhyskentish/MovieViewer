//
//  ContentView.swift
//  MovieViewer
//
//  Created by Rhys Kentish on 02/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = MovieListViewModel()
    
    @State var limited = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .center, spacing: .some(10), content: {
                    ForEach(viewModel.movies) { movie in
                        ZStack {
                            MovieComponent(movie: movie, deleteMovie: deleteMovie(moive:))
                                .animation(.easeInOut(duration: 0.3))
                                .padding()
                        }
                    }
                    .onMove(perform: moveItems(origin:destination:))
                    
                })
            })
            .navigationTitle("Top Movies")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                if !limited {
                    limited.toggle()
                    viewModel.limitMovies()
                }
            }, label: {
                Text("Limit")
            }))
        }
    }
    
    func deleteMovie(moive: MovieViewModel) {
        viewModel.deleteMovie(movie: moive)
    }
    
    func moveItems(origin: IndexSet, destination: Int) {
        viewModel.movies.move(fromOffsets: origin, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
