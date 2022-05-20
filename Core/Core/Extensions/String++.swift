//
//  String++.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import Foundation

public extension String {
    private static let imageUrl = "https://image.tmdb.org/t/p"
    
    /// Must be pass suitable and available quality, e.g. 400, 500,...
    public func addImageUrl(quality: Int = 400) -> String {
        return "\(String.imageUrl)/w\(quality)\(self)"
    }
}
