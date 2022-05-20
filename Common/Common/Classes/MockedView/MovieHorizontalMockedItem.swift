//
//  MovieHorizontalMockedItem.swift
//  Common
//
//  Created by ExecutionLab's Macbook on 20/05/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import Resources
import Domain

public struct MovieHorizontalMockedItem: View {
    
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
