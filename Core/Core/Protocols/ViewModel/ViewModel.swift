//
//  ViewModel.swift
//  Common
//
//  Created by Phat Le on 27/04/2022.
//

import Combine
import SwiftUI

public protocol AnyObservableObject: AnyObject {
    var objectWillChange: ObservableObjectPublisher { get }
}

public protocol ViewModel: AnyObservableObject {}

public protocol NavigatorModel: Navigator & ViewModel {}
