//
//  AppDelegate.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core

class AppDelegate: PluggableApplicationDelegate, ObservableObject, Resolving {
    override var services: [ApplicationService] {
        return [
        ]
    }
}

extension AppDelegate {
    func suspendApp() {
        DispatchQueue.main.async {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        }
    }
}
