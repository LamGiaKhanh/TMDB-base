//
//  TabState.swift
//  Core
//
//  Created by ExecutionLab's Macbook on 23/05/2022.
//

import SwiftUI

public class TabState: ObservableObject {
    @Published public var hideTabView: Bool = false
    
    public init() {
        
    }
}
