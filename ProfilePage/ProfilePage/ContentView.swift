import SwiftUI

let HORIZONTAL_SCROLLVIEW_IDENTIFIER = "horizontal_scrollview_identifier"
let HEADER_IMAGE_HEIGHT: CGFloat = 200
let TOP_BAR_HEIGHT: CGFloat = 50

struct ContentView: View {
    var geometryInfo = GeometryInfo()
    let items = Array(0..<10)
    
    @State private var selectedTab: PageTab = .like
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                List(items, id: \.self) { i in
                    NavigationLink("XXX \(i)", value: i)
                }
                .navigationTitle("XXX")
                .navigationDestination(for: Int.self) { value in
                    ProfilePage(userId: value, selectedTab: $selectedTab)
                        .navigationBarHidden(true)
                }
            }
        }
        .ignoresSafeArea(.all)
        .navigationViewStyle(.stack)
        .onGeometryChange { size, insets in
            geometryInfo.size = size
            geometryInfo.safeAreaInsets = insets
        }
        .environmentObject(geometryInfo)
    }
}

#Preview {
    ContentView()
}
