//
//  View++.swift
//  Common
//
//  Created by Phat Le on 28/04/2022.
//

import SwiftUI

// MARK: Navigation and present
public extension View {
    func onNavigation(_ action: @escaping () -> Void) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        return NavigationLink(
            destination: EmptyView(),
            isActive: isActive
        ) {
            self
        }
    }

    func navigation<Model, Destination: View>(
        model: Binding<Model?>,
        @ViewBuilder destination: (Model) -> Destination
    ) -> some View {
        let isActive = Binding(
            get: { model.wrappedValue != nil },
            set: { value in
                if !value {
                    model.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            model.wrappedValue.map(destination)
        }
    }

    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        overlay(
            NavigationLink(isActive: isActive, destination: {
                isActive.wrappedValue ? destination() : nil
            }, label: {
                EmptyView()
            })
        )
    }

    func sheet<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model) -> Content
    ) -> some View {
        sheet(item: model.objectIdentifiable()) { _ in
            model.wrappedValue.map(content)
        }
    }

    func fullScreenCover<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model) -> Content
    ) -> some View {
        fullScreenCover(item: model.objectIdentifiable()) { _ in
            model.wrappedValue.map(content)
        }
    }

    func popover<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model) -> Content
    ) -> some View {
        popover(item: model.objectIdentifiable()) { _ in
            model.wrappedValue.map(content)
        }
    }
}

// MARK: Others
public extension View {
    
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    func hideNavigationBar(_ isHidden: Bool = true, withBackButton: Bool = true) -> some View {
        navigationBarTitle("") // this must be empty
            .navigationBarHidden(isHidden)
            .navigationBarBackButtonHidden(withBackButton)
    }

    func matchParent() -> some View {
        frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }

    func matchWidth() -> some View {
        frame(
            minWidth: 0,
            maxWidth: .infinity
        )
    }

    func matchHeight() -> some View {
        frame(
            minHeight: 0,
            maxHeight: .infinity
        )
    }
}

// MARK: Hide Keyboard

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    public func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
