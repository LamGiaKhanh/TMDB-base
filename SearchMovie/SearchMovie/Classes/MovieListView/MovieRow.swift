//
//  MovieRows.swift
//  App
//
//  Created by ExecutionLab's Macbook on 16/05/2022.
//

import SwiftUI
import Core
import Domain
import Resources
import SDWebImageSwiftUI
import SkeletonUI

fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

public struct MovieRow: View {
    var movie: Movie?
    var loading: Bool
    var displayListImage = true
    
    public init(movie: Movie?, loading: Bool) {
        self.movie = movie
        self.loading = loading
    }
    
    public var body: some View {
        HStack {
            WebImage(url: URL(string: movie?.posterPath.addImageUrl() ?? ""))
                .resizable()
                .frame(width: 100, height: 150)
                .scaledToFill()
                .cornerRadius(5)
                .shadow(color: .gray.opacity(0.5), radius: 4)
                .skeleton(with: loading, size: CGSize(width: 100, height: 150))
                .shape(type: .rounded(.radius(5, style: .circular)))
                .appearance(type: .gradient())
                .animation(type: .linear())
            VStack(alignment: .leading, spacing: 8) {
                Text(movie?.title ?? "")
                    .foregroundColor(R.color.steam_gold.color)
                    .titleStyle()
                    .lineLimit(2)
                    .skeleton(with: loading, size: CGSize(width: 220, height: 20))
                    .shape(type: .rectangle)
                    .appearance(type: .gradient())
                    .animation(type: .linear())
                HStack {
                    PopularityBadge(score: Int((movie?.voteAverage ?? 1) * 10), textColor: R.color.steam_rust.color)
                        .skeleton(with: loading, size: CGSize(width: 48, height: 48))
                        .shape(type: .circle)
                        .appearance(type: .gradient(.angular))
                        .animation(type: .linear())
                    Text(movie?.releaseDate ?? "")
                        .foregroundColor(R.color.steam_background.color)
                        .font(R.font.fjallaOneRegular.font(size: 14))
                        .lineLimit(1)
                        .skeleton(with: loading, size: CGSize(width: 160, height: 20))
                        .shape(type: .rectangle)
                        .appearance(type: .gradient())
                        .animation(type: .linear())
                }
                Text(movie?.overview ?? "")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 12))
                    .lineLimit(3)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity)
                    .skeleton(with: loading, size: CGSize(width: 200, height: 20))
                    .shape(type: .rectangle)
                    .multiline(lines: 3)
                    .appearance(type: .gradient())
                    .animation(type: .linear())
            }.padding(.leading, 8)
        }.padding(.top, 8)
            .padding(.bottom, 8)
            .listRowBackground(Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .redacted(reason: movie?.id == 0 ? .placeholder : [])
            .background(R.image.night_sky.image.resizable())
    }
}
