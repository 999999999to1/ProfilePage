import SwiftUI

struct GeometryInfoModifier: ViewModifier {
    var onChange: (CGSize, EdgeInsets) -> Void
    
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: GeometryInfoPreferenceKey.self,
                    value: GeometrySnapshot(size: proxy.size, safeAreaInsets: proxy.safeAreaInsets)
                )
            }
        )
        .onPreferenceChange(GeometryInfoPreferenceKey.self) { value in
            onChange(value.size, value.safeAreaInsets)
        }
    }
}

extension View {
    func onGeometryChange(_ onChange: @escaping (CGSize, EdgeInsets) -> Void) -> some View {
        modifier(GeometryInfoModifier(onChange: onChange))
    }
}
