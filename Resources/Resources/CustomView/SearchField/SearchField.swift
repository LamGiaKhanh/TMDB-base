//
//  SearchField.swift
//  Resources
//
//  Created by ExecutionLab's Macbook on 16/05/2022.
//

import Foundation
import SwiftUI
import Combine

@available(iOS 13.0, OSX 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct SearchField : View {
    @ObservedObject var searchTextWrapper: SearchTextObservable
    let placeholder: String
    @Binding var isSearching: Bool
    var dismissButtonTitle: String
    var dismissButtonCallback: (() -> Void)?
    
    private var searchCancellable: Cancellable? = nil
    
    public init(searchTextWrapper: SearchTextObservable,
         placeholder: String,
         isSearching: Binding<Bool>,
         dismissButtonTitle: String = "Cancel",
         dismissButtonCallback: (() -> Void)? = nil) {
        self.searchTextWrapper = searchTextWrapper
        self.placeholder = placeholder
        self._isSearching = isSearching
        self.dismissButtonTitle = dismissButtonTitle
        self.dismissButtonCallback = dismissButtonCallback
        
        self.searchCancellable = searchTextWrapper.searchSubject.sink(receiveValue: { value in
            isSearching.wrappedValue = !value.isEmpty
        })
    }
    
    public var body: some View {
        GeometryReader { reader in
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: "magnifyingglass")
                TextField(self.placeholder,
                          text: self.$searchTextWrapper.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                if !self.searchTextWrapper.searchText.isEmpty {
                    Button(action: {
                        self.searchTextWrapper.searchText = ""
                        self.isSearching = false
                        self.dismissButtonCallback?()
                    }, label: {
                        Text(self.dismissButtonTitle).foregroundColor(.pink)
                    })
                    .buttonStyle(BorderlessButtonStyle())
                    .animation(.easeInOut)
                }
            }
            .preference(key: OffsetTopPreferenceKey.self,
                        value: reader.frame(in: .global).minY)
            .padding(4)
        }.frame(height: 44)
    }
}
