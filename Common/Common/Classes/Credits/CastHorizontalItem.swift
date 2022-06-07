//
//  CastHorizontalItem.swift
//  Common
//
//  Created by ExecutionLab's Macbook on 24/05/2022.
//

import Foundation
import Domain
import SwiftUI
import SDWebImageSwiftUI
import Resources

public struct CastHorizontalItem: View {
    
    var cast: Cast?
    var loading: Bool
    
    @State public var isCast: Bool
    
    public init(cast: Cast?, loading: Bool, isCast: Bool) {
        self.cast = cast
        self.loading = loading
        _isCast = State(initialValue: isCast)
    }
    
    public var body: some View {
            VStack {
                WebImage(url: URL(string: cast?.profilePath.addImageUrl(quality: 300) ?? ""))
                    .resizable()
                    .placeholder(cast?.gender == 0 ? R.image.malePlaceholder.image.resizable() : R.image.femalePlaceholder.image.resizable())
                    .scaledToFill()
                    .frame(width: 125, height: 180, alignment: .top)
                    .cornerRadius(10)
                    .padding(.top, 4)
                    .skeleton(with: loading, size: CGSize(width: 125, height: 180))
                    .shape(type: .rounded(.radius(10, style: .circular)))
                    .appearance(type: .gradient())
                    .animation(type: .linear())
                AppText(.content, cast?.name ?? "")
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .skeleton(with: loading, size: CGSize(width: 120, height: 20))
                    .shape(type: .rectangle)
                    .appearance(type: .gradient())
                    .animation(type: .linear())
                AppText(.overview, cast != nil ? (isCast ? "as \(cast!.character)" : "\(cast!.job)") : "huh")
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .skeleton(with: loading, size: CGSize(width: 120, height: 20))
                    .shape(type: .rectangle)
                    .appearance(type: .gradient())
                    .animation(type: .linear())
                Spacer()
            }
            .frame(width: 120, height: 280)
    }
}
