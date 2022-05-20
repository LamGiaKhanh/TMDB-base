//
//  DomainAssembly.swift
//  Alamofire
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation
import Core

public class DomainAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(AuthenticateUseCase.self) { _ in
            AuthenticateUseCase()
        }
        container.register(LogOutUseCase.self) { _ in
            LogOutUseCase()
        }
        container.register(RefreshTokenUseCase.self) { _ in
            RefreshTokenUseCase()
        }
        container.register(SearchMovieUseCase.self) { _ in
            SearchMovieUseCase()
        }
        
        container.register(MovieDetailUseCase.self) { _ in
            MovieDetailUseCase()
        }
        
        container.register(MovieCategoryUseCase.self) { _ in
            MovieCategoryUseCase()
        }
        
        container.register(MovieRecommendationsUseCase.self) { _ in
            MovieRecommendationsUseCase()
        }
    }
}
