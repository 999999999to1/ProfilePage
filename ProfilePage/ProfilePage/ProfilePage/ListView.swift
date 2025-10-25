import SwiftUI
import SwiftUIIntrospect

struct ListView: View {
    let tab: PageTab
    
    @EnvironmentObject private var profilePageModel: ProfilePageModel
    @EnvironmentObject private var geometryInfo: GeometryInfo
    
    @State private var coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                VStack(spacing: 0) {
                    Color.clear.frame(height: HEADER_IMAGE_HEIGHT + profilePageModel.state.tabRowHeight)
                    
                    Color.clear.background {
                        GeometryReader { proxy in
                            Color.clear.preference(
                                key: VerticalScrollOffsetPreferenceKey.self,
                                value: proxy.frame(in: .named(coordinateSpaceName)).origin.y
                            )
                        }
                    }
                    .onPreferenceChange(VerticalScrollOffsetPreferenceKey.self) { offset in
                        profilePageModel.verticalScrollOffsetChanged(offset, tab: tab)
                    }
                    
                    /// -------------------
                    let numbers = [26, 4, 125]
                    let number = switch tab {
                    case .like: numbers[0]
                    case .collect: numbers[1]
                    case .comment: numbers[2]
                    }
                    let background = switch tab {
                    case .like: Color.pink.opacity(0.6)
                    case .collect: Color.purple.opacity(0.6)
                    case .comment: Color.teal.opacity(0.6)
                    }
                    
                    ForEach(Array(0..<number), id: \.self) { index in
                        VStack(spacing: 0) {
                            Spacer()
                            Text("\(tab.name) ---- ROW \(index)")
                                .font(.system(size: 20))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .background(background)
                        .cornerRadius(4)
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            print("TAP")
                        }
                        
                        Spacer().frame(height: 10)
                    }
                    /// -------------------
                }
            }
        }
        .coordinateSpace(name: coordinateSpaceName)
        .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18, .v26)) { scrollView in
            if profilePageModel.state.verticalScrollViews[tab] !== scrollView {
                Task { @MainActor in
                    profilePageModel.verticalScrollViewChanged(scrollView, tab: tab)
                }
            }
        }
    }
}
