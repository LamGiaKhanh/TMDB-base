//
//  MovieRows.swift
//  App
//
//  Created by ExecutionLab's Macbook on 16/05/2022.
//

import SwiftUI
import Domain
import SDWebImageSwiftUI

fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

public struct MovieRow: View {
    
    var movie: Movie
    var displayListImage = true
    
    public init(movie: Movie) {
        self.movie = movie
    }

    public var body: some View {
        HStack {
            WebImage(url: URL(string: movie.posterPath.addImageUrl()))
                .resizable()
                .frame(width: 100, height: 150)
                .scaledToFill()
                .cornerRadius(5)
                .shadow(radius: 8)
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .foregroundColor(.yellow)
                    .lineLimit(2)
                HStack {
                    PopularityBadge(score: Int(movie.voteAverage * 10))
                    Text(movie.releaseDate)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }
                Text(movie.overview)
                    .foregroundColor(.secondary)
                    .font(.system(size: 12))
                    .lineLimit(3)
                    .truncationMode(.tail)
            }.padding(.leading, 8)
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .redacted(reason: movie.id == 0 ? .placeholder : [])
    }
}
