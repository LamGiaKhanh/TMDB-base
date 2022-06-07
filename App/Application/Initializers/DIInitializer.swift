//
//  DIInitializer.swift
//  StreamApp
//
//  Created by Phat Le on 12/04/2022.
//

import Core
import Domain
import Data
import DashboardTab
import SearchMovie
import Common

class DIInitializer: Initializable {
    func performInitialization() {
        RootAssembler.standard.apply(assemblies: [
            ConfigurationAssembly(mode: EnvironmmentMode(rawValue: AppConstants.environmentMode)),
            DomainAssembly(),
            DataAssembly(),
            AppServicesAssembly(),
            ScenesAssembly(),
            DashboardTabAssembly(),
            SearchMovieAssembly()
        ])
    }
}
