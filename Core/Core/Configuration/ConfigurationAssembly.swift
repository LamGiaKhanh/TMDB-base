//
//  ConfigurationAssembly.swift
//  Configuration
//
//  Created by Phat Le on 06/04/2022.
//

public class ConfigurationAssembly: Assembly {
    let mode: EnvironmmentMode

    public init (mode: EnvironmmentMode?) {
        self.mode = mode ?? .development
    }

    public func assemble(container: Container) {
        container.register(Environment.self) { _ in
            ConfigurationEnvironment(mode: self.mode)
        }.inObjectScope(.container)
    }
}
