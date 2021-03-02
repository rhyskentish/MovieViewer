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
    
    var body: some View {
        HStack(alignment: .center, spacing: .some(8), content: {
            WebImage(url: URL(string: movie.imageUrl))
            // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
            .onSuccess { image, data, cacheType in
                // Success
                // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
            }
            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
            .placeholder(Image(systemName: "placeholder")) // Placeholder Image
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
            .scaledToFit()
            .frame(width: 64, height: 64, alignment: .leading)
            VStack(alignment: .leading, spacing: .some(4), content: {
                Text(movie.fullTitle)
                Text("Rating: \(movie.imDbRating)")
            })
            Button(action: {
                print("Chevron was tapped")
            }) {
                Image("Icon-ChevronThinDown")
            }
        })
    }
}

struct MovieComponent_Privews: PreviewProvider {
    static var previews: some View {
        MovieComponent(movie: MovieViewModel(movie: Movie(id: "1", rank: "1", imDbRating: "8", fullTitle: "Some movie", image: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX128_CR0,3,128,176_AL_.jpg", crew: "")))
    }
}
