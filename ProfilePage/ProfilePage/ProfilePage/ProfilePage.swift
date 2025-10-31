import SwiftUI
import SwiftUIIntrospect

struct ProfilePage: View {
    var userId: Int
    @Binding private var selectedTab: PageTab
    @EnvironmentObject private var geometryInfo: GeometryInfo
    @StateObject private var profilePageModel: ProfilePageModel
    @State private var coordinateSpaceName = UUID()
    
    public init(userId: Int, selectedTab: Binding<PageTab>) {
        self.userId = userId
        _selectedTab = selectedTab
        _profilePageModel = StateObject(wrappedValue: ProfilePageModel())
    }
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack(alignment: .top) {
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(PageTab.allCases) { tab in
                            ListView(tab: tab).id(tab)
                        }
                        .scrollClipDisabled()
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                    }
                    .scrollTargetLayout()
                    .overlay(alignment: .leading) {
                        Color.clear.background(
                            GeometryReader { horizontalProxy in
                                Color.clear
                                    .preference(key: HorizontalScrollOffsetPreferenceKey.self,
                                                value: -horizontalProxy.frame(in: .named(coordinateSpaceName)).minX)
                            }
                        )
                        .frame(width: 0, height: 0)
                        .onPreferenceChange(HorizontalScrollOffsetPreferenceKey.self) { value in
                            profilePageModel.horizontalScrollOffsetChanged(value)
                        }
                    }
                }
                .coordinateSpace(name: coordinateSpaceName)
                .scrollTargetBehavior(.paging)
                .scrollClipDisabled()
                .scrollIndicators(.never)
                .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18, .v26)) { scrollView in
                    scrollView.bounces = false
                    scrollView.accessibilityIdentifier = HORIZONTAL_SCROLLVIEW_IDENTIFIER
                }
                
                HeaderView(userId: userId) { index in
                    scrollProxy.scrollTo(PageTab.allCases[index], anchor: .center)
                }
                .onPreferenceChange(TabRowHeightPreferenceKey.self) { height in
                    profilePageModel.tabRowHeightChanged(height)
                }
            }
        }
        .ignoresSafeArea(.all)
        .environmentObject(profilePageModel)
    }
}
