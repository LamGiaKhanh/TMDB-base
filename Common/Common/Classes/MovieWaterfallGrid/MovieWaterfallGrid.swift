//
//  MovieWaterfallGrid.swift
//  Common
//
//  Created by ExecutionLab's Macbook on 01/06/2022.
//

import SwiftUI
import Domain
import SkeletonUI
import Resources
import SDWebImageSwiftUI
import WaterfallGrid

public struct MovieWaterfallGridView: View {
    
    public var movies: [Movie]
    public var movieSelected: ((Movie) -> Void)?
    
    @State private var size: CGSize = .init()

    public init(movies: [Movie], movieSelected: ((Movie) -> Void)? = nil) {
        self.movies = movies
        self.movieSelected = movieSelected
    }
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            WaterfallGrid(movies) { movie in
                WebImage(url: URL(string: movie.posterPath.addImageUrl(quality: 300)))
                    .resizable()
                    .indicator(.activity)
                    .foregroundColor(R.color.steam_background.color)
                    .clipped()
                    .scaledToFill()
                    .frame(width: size.width / 3, height: CGFloat.random(in: 160...180))
                    .onTapGesture {
                        movieSelected!(movie)
                    }
            }
            .readSize(onChange: { size in
                self.size = size
            })
            .gridStyle(
              columnsInPortrait: 3,
              columnsInLandscape: 3,
              spacing: 4,
              animation: .easeInOut(duration: 0.5)
            )
            .scrollOptions(direction: .vertical)
            .background(R.image.night_sky.image.resizable())
        }
    }
}

