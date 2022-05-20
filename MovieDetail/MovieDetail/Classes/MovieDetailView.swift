//
//  MovieDetailView.swift
//  MovieDetail
//
//  Created by ExecutionLab's Macbook on 17/05/2022.
//

import Foundation
import SwiftUI
import Core
import Resources
import SDWebImageSwiftUI

public struct MovieDetailView: View {
    @Store public var viewModel: MovieDetailViewModel
    
    @State private var query: String = ""
    @State private var isSearching = false

    public init(viewModel: MovieDetailViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    public var body: some View {
        let movie = viewModel.movie
        
        GeometryReader { geometry in
            let width = geometry.size.width
            
            ZStack(alignment: .topLeading) {
                WebImage(url: URL(string: movie.posterPath.addImageUrl(quality: 500))!)
                    .resizable()
                    .frame(width: width, height: width * 1.5)
                    .scaledToFit()
                    .aspectRatio(2/3, contentMode: .fit)
                    .ignoresSafeArea()
            }
            .foregroundColor(R.color.steam_rust.color)
        }
        .navigationBarTitle("")
    }
}
