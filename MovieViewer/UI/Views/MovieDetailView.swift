//
//  MovieDetailView.swift
//  MovieViewer
//
//  Created by Rhys Kentish on 04/03/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    @State var shouldInverseViews = false
    
    var movie: MovieViewModel
    
    var body: some View {
        MovieDetailViews(shouldInverse: shouldInverseViews,
            AnyView(WebImage(url: URL(string: movie.imageUrl))
                        .onSuccess { image, data, cacheType in
                            // Success
                            // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                        }
                        .resizable()
                        .placeholder(Image(systemName: "placeholder"))
                        .indicator(.activity)
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
            ),
            AnyView(Text(movie.fullTitle).bold()),
            AnyView(Text("Rating: \(movie.imDbRating)")),
            AnyView(Text(movie.crew)),
            AnyView(Spacer())
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(movie.title)
        .navigationBarItems(trailing: Button(action: {
            shouldInverseViews.toggle()
        }, label: {
            Image("Icon-ArrowsUpDown")
        }))
    }
}

struct MovieDetailViews<AnyView: View>: View {
    var views: [AnyView]
    
    init(shouldInverse: Bool = false, _ views: AnyView...) {
        self.views = views
        if shouldInverse {
            self.views.reverse()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            ForEach(0..<views.count) { index in
                self.views[index]
                    .animation(.ripple(index: index))
            }
        })
    }
}

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.05 * Double(index))
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieViewModel(movie: Movie(id: "1", rank: "1", imDbRating: "8", fullTitle: "Some movie", title: "movie", image: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX128_CR0,3,128,176_AL_.jpg", crew: "")))
    }
}
