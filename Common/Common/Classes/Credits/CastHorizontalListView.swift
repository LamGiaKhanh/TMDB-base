//
//  CastHorizontalListView.swift
//  Common
//
//  Created by ExecutionLab's Macbook on 24/05/2022.
//

import SwiftUI
import Domain
import SkeletonUI
import Resources

public struct CastHorizontalListView: View {
    
    public var casts: [Cast]
    public var castSelected: ((Cast) -> Void)?
    
    @State public var isCast: Bool
    
    public init(casts: [Cast], isCast: Bool = false, castSelected: ((Cast) -> Void)? = nil) {
        self.casts = casts
        self.castSelected = castSelected
        _isCast = State(initialValue: isCast)
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 4) {
                SkeletonForEach(with: casts, quantity: 6) { loading , cast in
                    CastHorizontalItem(cast: cast, loading: loading, isCast: isCast)
                        .padding(.horizontal, 4)
                        .onTapGesture {
                            if let cast = cast, let castSelected = castSelected {
                                castSelected(cast)
                                print("Tapped movie \(cast.id)")
                            }
                        }
                }
            }.background(R.image.night_sky.image.resizable())
        }
    }
}

