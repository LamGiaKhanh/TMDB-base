//
//  ImageProviding.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import SwiftUI

public protocol ImageProviding {
    var imageName: String { get }
    var imageBundle: Bundle { get }
}

public extension ImageProviding where Self: RawRepresentable, Self.RawValue == String {
    var imageName: String { rawValue }
}

public extension ImageProviding {
    func callAsFunction() -> Image {
        Image.load(imageName, bundle: imageBundle)
    }

    func callAsFunction() -> UIImage {
        UIImage.load(imageName, bundle: imageBundle)
    }
}
