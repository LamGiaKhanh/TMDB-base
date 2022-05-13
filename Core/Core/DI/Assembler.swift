//
//  Assembler.swift
//  di
//
//  Created by Phat Le on 29/08/2021.
//

import Swinject

public class RootAssembler {
    public static let standard = RootAssembler()

    private let assembler: Assembler
    private let container: Container

    public var resolver: Resolver {
        container.synchronize()
    }

    public init(assemblies: [Assembly] = [], container: Container = Container()) {
        self.container = container
        self.assembler = Assembler(assemblies, container: container)
    }

    public func apply(assembly: Assembly) {
        assembler.apply(assembly: assembly)
    }

    public func apply(assemblies: [Assembly]) {
        assembler.apply(assemblies: assemblies)
    }
}
