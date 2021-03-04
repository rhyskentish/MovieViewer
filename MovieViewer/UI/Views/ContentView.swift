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
    @State var editMode = EditMode.inactive
    
    var body: some View {
        NavigationView {
            if(viewModel.isLoading) {
                Text("Loading...")
            } else {
                if let error = viewModel.error {
                    VStack(alignment: .center, spacing: 8, content: {
                        Text("Error")
                        Text(error)
                    })
                } else {
                    if(viewModel.movies.count == 0) {
                        VStack(alignment: .center, spacing: 8, content: {
                            Spacer()
                            Text("No Data")
                            Spacer()
                            Button(action: {
                                viewModel.fetchAllMovies()
                            }) {
                                Text("Fetch Data")
                                    .frame(maxWidth: .infinity, minHeight: 44)
                            }
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding()
                        })
                    } else {
                        List{
                            ForEach(viewModel.movies) { movie in
                                ZStack {
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        EmptyView()
                                    }.hidden()
                                    MovieComponent(movie: movie, isEditing: self.editMode == .active)
                                        .animation(.easeInOut(duration: 0.3))
                                        .padding()
                                }
                            }
                            .onMove(perform: moveItems(origin:destination:))
                            .onDelete(perform: deleteMovie)
                            .deleteDisabled(self.editMode == .active)
                        }
                        .navigationTitle("Top Movies")
                        .navigationBarItems(leading: editButton, trailing: Button(action: {
                            if !limited {
                                limited.toggle()
                                viewModel.limitMovies()
                            }
                        }, label: {
                            Text("Limit")
                        }))
                        .environment(\.editMode, self.$editMode)
                    }
                }
                
            }
        }
    }
    
    private var editButton: some View {
        if editMode == .inactive {
            return Button(action: {
                self.editMode = .active
            }) {
                Text("Edit")
            }
        }
        else {
            return Button(action: {
                self.editMode = .inactive
            }) {
                Text("Done")
            }
        }
    }
    
    
    func deleteMovie(indexSet: IndexSet) {
        viewModel.deleteMovie(index: indexSet)
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
