//
//  MovieDetailView.swift
//  MovieDetail
//
//  Created by ExecutionLab's Macbook on 17/05/2022.
//

import SwiftUI
import Core
import Resources
import SDWebImageSwiftUI
import Common

public struct MovieDetailView: View {
    @Store public var viewModel: MovieDetailViewModel
    @SwiftUI.Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State private var query: String = ""
    @State private var isSearching = false
    @State var isRootView: Bool
    
    public init(viewModel: MovieDetailViewModel, isRootView: Bool) {
        _viewModel = Store(wrappedValue: viewModel)
        _isRootView = State(initialValue: isRootView)
    }
    
    public var body: some View {
        let movie = viewModel.movie
        
        ScrollView(showsIndicators: false) {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
                        WebImage(url: URL(string: movie.posterPath.addImageUrl(quality: 500)))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(y: geometry.frame(in: .global).minY/9)
                            .clipped()
                            .ignoresSafeArea()
                    } else {
                        WebImage(url: URL(string: movie.posterPath.addImageUrl(quality: 500)))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                            .ignoresSafeArea()
                    }
                }
            }
            .frame(height: 600)
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .top) {
                    AppText(.movieTitle, "\(movie.title)")
                        .foregroundColor(R.color.steam_gold.color)
                        .font(R.font.fjallaOneRegular.font(size: 36))
                        .fixedSize(horizontal: false, vertical: true)
                    Text("\(movie.releaseDate)")
                        .foregroundColor(R.color.content.color)
                        .font(R.font.americanCaptain.font(size: 14))
                    Spacer()
                    PopularityBadge(score: Int(movie.voteAverage * 10), textColor: R.color.steam_gold.color)
                        .padding(.trailing, 8)
                }
                AppText(.overview, "\(movie.overview)")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 8)
                
                Divider().background(R.color.tab_color.color)
                
                VStack(alignment: .leading, spacing: 4) {
                    AppText(.section, "Cast")
                    CastHorizontalListView(casts: viewModel.castList, isCast: true) { cast in
                        print("Tapped \(cast.name) with id: \(cast.id)")
                    }
                    Divider().background(R.color.tab_color.color)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    AppText(.section, "Crew")
                    CastHorizontalListView(casts: viewModel.crewList) { crew in
                        print("Tapped \(crew.name) with id: \(crew.id)")
                    }
                    Divider().background(R.color.tab_color.color)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    AppText(.section, "Recommendation")
                    MoviesHorizontalListView(movies: viewModel.recommendationList) { movie in
                        viewModel.steps.send(MovieDetailStep.movieDetail(movie))
                    }
                    Divider().background(R.color.tab_color.color)
                }.hidden(viewModel.recommendationList.isEmpty)
                
                AppText(.section, "Similar")
                MovieWaterfallGridView(movies: viewModel.similarList) { movie in
                    viewModel.steps.send(MovieDetailStep.movieDetail(movie))

                }.frame(maxWidth: .infinity)
            }
            .padding([.leading, .trailing], 8)
            
        }
        .onAppear(perform: {
            viewModel.chainingFetch(with: "\(movie.id)")
        })
        .overlay(
            HStack {
                TransparentButton(buttonType: .medium, image: R.image.back_btn.image.renderingMode(.template)) {
                    self.mode.wrappedValue.dismiss()
                }
                    .hidden(isRootView)
                    .foregroundColor(R.color.steam_gold.color)
                Spacer()
                TransparentButton(buttonType: .medium, image: R.image.close_btn.image.renderingMode(.template)) {
                    viewModel.steps.send(DashboardStep.popToRoot)
                    print("Close tapped")
                }
                    .foregroundColor(R.color.steam_gold.color)
            },
            alignment: .top
        )
        .edgesIgnoringSafeArea(.bottom)
        .background(ZStack {
            ColorfulView()
            Color.black
                .opacity(0.98)
                .ignoresSafeArea()
        })
    }
}
