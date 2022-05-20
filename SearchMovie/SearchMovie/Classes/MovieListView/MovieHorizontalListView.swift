//
//  MovieHorizontalListView.swift
//  Common
//
//  Created by ExecutionLab's Macbook on 18/05/2022.
//

import SwiftUI
import Domain
import SkeletonUI
import Resources

public struct MoviesHorizontalListView: View {
    
    public var movies: [Movie]
    
    public var movieSelected: ((Movie) -> Void)

    public init(movies: [Movie], movieSelected: @escaping ((Movie) -> Void)) {
        self.movies = movies
        self.movieSelected = movieSelected
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 4) {
                SkeletonForEach(with: movies, quantity: 6) { loading , movie  in
                    MovieHorizontalItem(movie: movie, loading: loading)
                        .padding(.horizontal, 4)
                        .onTapGesture {
                            if let movie = movie {
                                movieSelected(movie)
                                 print("Tapped movie \(movie.title)")
                            }
                        }
                }
            }
        }
    }
}

