//
//  MovieHorizontalItem.swift
//  Common
//
//  Created by ExecutionLab's Macbook on 18/05/2022.
//

import Domain
import SwiftUI
import SDWebImageSwiftUI
import Resources

public struct MovieHorizontalItem: View {
    
    var movie: Movie?
    var loading: Bool
    
    public init(movie: Movie?, loading: Bool) {
        self.movie = movie
        self.loading = loading
    }
    
    public var body: some View {
            VStack {
                WebImage(url: URL(string: movie?.posterPath.addImageUrl(quality: 300) ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 125, height: 180)
                    .cornerRadius(10)
                    .padding(.top, 4)
                    .skeleton(with: loading, size: CGSize(width: 125, height: 180))
                    .shape(type: .rounded(.radius(10, style: .circular)))
                    .appearance(type: .gradient())
                    .animation(type: .linear())
                AppText(.content, movie?.title ?? "")
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .skeleton(with: loading, size: CGSize(width: 120, height: 20))
                    .shape(type: .rectangle)
                    .appearance(type: .gradient())
                    .animation(type: .linear())
                Text(movie?.releaseDate)
                    .lineLimit(1)
                    .font(R.font.fjallaOneRegular.font(size: 13))
                    .foregroundColor(R.color.tab_color.color)
                    .skeleton(with: loading, size: CGSize(width: 120, height: 20))
                    .shape(type: .rectangle)
                    .appearance(type: .gradient())
                    .animation(type: .linear())
                Spacer()
                PopularityBadge(score: Int((movie?.voteAverage ?? 2) * 10), textColor: R.color.steam_rust.color)
                    .skeleton(with: loading, size: CGSize(width: 40, height: 40))
                    .shape(type: .circle)
                    .appearance(type: .gradient(.angular))
                    .animation(type: .linear())
                    .padding(.bottom, 4)
            }.frame(width: 120, height: 300)
    }
}
