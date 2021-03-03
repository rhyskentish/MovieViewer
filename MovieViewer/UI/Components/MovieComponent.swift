//
//  MovieComponent.swift
//  MovieViewer
//
//  Created by Rhys Kentish on 02/03/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieComponent: View {
    var movie: MovieViewModel
    
    var deleteMovie: ((_ movie: MovieViewModel) -> Void)?
    
    @State var isExpanded = false
    @State var offset = CGSize.zero
    
    let subItem = Text("snad")
    
    var body: some View {
        VStack(alignment: .leading, spacing: .some(4), content: {
            ZStack{
                HStack {
                    Spacer()
                    Button(action: {
//                        withAnimation(.linear) {
                            if let deleteMovie = deleteMovie {
                                deleteMovie(movie)
                            }
//                        }
                    }, label: {
                        Text("Delete")
                            .frame(maxWidth: offset.width > -60 ? .some(64) : -offset.width, maxHeight: .some(60))
                            .background(Color.red)
                            .foregroundColor(Color.white)
                    })
                }
                
                HStack(alignment: .center, spacing: .some(8), content: {
                    WebImage(url: URL(string: movie.imageUrl))
                        .onSuccess { image, data, cacheType in
                            // Success
                            // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                        }
                        .resizable()
                        .placeholder(Image(systemName: "placeholder"))
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: 64, height: 64, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: .some(4), content: {
                        Text(movie.fullTitle)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Rating: \(movie.imDbRating)")
                    })
                    Spacer()
                    
                    Button(action: {
                        self.isExpanded.toggle()
                    }) {
                        Image("Icon-ChevronThinDown")
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .animation(.easeInOut)
                    }
                    .buttonStyle(PlainButtonStyle())
                })
                .background(Color.white)
                .offset(self.offset)
                .animation(.spring())
                .gesture(DragGesture()
                            .onChanged { gesture in
                                self.offset.width = gesture.translation.width
                            }
                            .onEnded { _ in
                                if self.offset.width < -50 {
                                    if self.offset.width < -200 {
                                        if let deleteMovie = deleteMovie {
                                            deleteMovie(movie)
                                        }
                                    } else {
                                        
                                        self.offset.width = -60
                                    }
                                } else {
                                    self.offset = .zero
                                }
                            }
                )
            }
            if(isExpanded) {
                VStack(alignment: .center, spacing: nil, content: {
                    Text(movie.crew)
                })
            }
        })
    }
}

struct MovieComponent_Privews: PreviewProvider {
    func delete(movie: MovieViewModel) {}
    
    static var previews: some View {
        MovieComponent(movie: MovieViewModel(movie: Movie(id: "1", rank: "1", imDbRating: "8", fullTitle: "Some movie", image: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX128_CR0,3,128,176_AL_.jpg", crew: "")))
    }
}
