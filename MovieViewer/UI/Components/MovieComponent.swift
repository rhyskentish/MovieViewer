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
    var isEditing: Bool
    
    @State var isExpanded = false
    @State var offset = CGSize.zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: .some(4), content: {
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
            if(isExpanded) {
                VStack(alignment: .center, spacing: nil, content: {
                    Text(movie.crew)
                })
                .animation(.easeInOut(duration: 0.3))
            }
        })
        .animation(nil)
        .padding(.leading, isEditing ? -64 : 0)
    }
}

struct MovieComponent_Privews: PreviewProvider {
    static var previews: some View {
        MovieComponent(movie: MovieViewModel(movie: Movie(id: "1", rank: "1", imDbRating: "8", fullTitle: "Some movie", image: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX128_CR0,3,128,176_AL_.jpg", crew: "")), isEditing: false)
    }
}
