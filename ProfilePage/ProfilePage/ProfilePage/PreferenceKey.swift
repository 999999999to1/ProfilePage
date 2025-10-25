import SwiftUI

struct GeometrySnapshot: Equatable {
    var size: CGSize
    var safeAreaInsets: EdgeInsets
}

class GeometryInfo: ObservableObject {
    @Published var size: CGSize = .zero
    @Published var safeAreaInsets: EdgeInsets = EdgeInsets()
}

struct GeometryInfoPreferenceKey: PreferenceKey {
    static var defaultValue: GeometrySnapshot = .init(size: .zero, safeAreaInsets: .init())
    static func reduce(value: inout GeometrySnapshot, nextValue: () -> GeometrySnapshot) {
        value = nextValue()
    }
}

struct VerticalScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct HorizontalScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TabRowHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        let next = nextValue()
        value = max(value, next)
    }
}

struct TabPreferenceData: Equatable {
    let index: Int
    let bounds: Anchor<CGRect>
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: [TabPreferenceData] = []
    static func reduce(value: inout [TabPreferenceData], nextValue: () -> [TabPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
