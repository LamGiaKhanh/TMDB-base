//
//  PreviewMocked.swift
//  App
//
//  Created by ExecutionLab's Macbook on 19/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Resources
import Common
import Domain

public struct MovieHorizontalItemMocked: View {
    
    var movie: Movie
    
    public init(movie: Movie) {
        self.movie = movie
    }
    
    public var body: some View {
        VStack {
            WebImage(url: URL(string: movie.posterPath.addImageUrl(quality: 300)))
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 180)
                .background(R.color.steam_gold.color)
                .cornerRadius(10)
                .shadow(color: R.color.steam_white.color, radius: 6, x: -2, y: 2)
            HStack {
                AppText(.content, movie.title)
                PopularityBadge(score: Int(movie.voteAverage * 10))
            }
        }
    }
}


struct PreviewMocked_Previews: PreviewProvider {
    static var previews: some View {
        MovieHorizontalItemMocked(movie: Movie())
    }
}
