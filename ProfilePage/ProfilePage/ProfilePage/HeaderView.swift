import SwiftUI
import UIKit

struct HeaderView: View {
    var userId: Int
    var onTabSelected: (Int) -> Void
    @EnvironmentObject private var profilePageModel: ProfilePageModel
    @EnvironmentObject private var geometryInfo: GeometryInfo
    @Environment(\.dismiss) private var dismiss
    
    @State private var scrollOffsetY: CGFloat = 0
    @State private var selectedTabIndex: Int = 0
    
    var headerViewHeight: CGFloat {
        HEADER_IMAGE_HEIGHT + profilePageModel.state.tabRowHeight
    }
    
    var scale: CGFloat{
        scrollOffsetY > 0 ? 1 + scrollOffsetY / HEADER_IMAGE_HEIGHT : 1
    }
    
    var backgroundOffsetY: CGFloat {
        if scrollOffsetY > 0 {
            return 0
        } else {
            let visibleHeight = headerViewHeight + scrollOffsetY
            
            if visibleHeight > TOP_BAR_HEIGHT + profilePageModel.state.tabRowHeight + geometryInfo.safeAreaInsets.top {
                return scrollOffsetY
            } else {
                return TOP_BAR_HEIGHT + profilePageModel.state.tabRowHeight + geometryInfo.safeAreaInsets.top - headerViewHeight
            }
        }
    }
    
    var dismissButtonOffsetY: CGFloat {
        return -backgroundOffsetY
    }
    
    var contentOffsetY: CGFloat {
        if scrollOffsetY > 0 {
            return scrollOffsetY
        } else {
            return 0
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            /// 设置一个可伸缩的头部背景，并在其上叠加 HeaderBackgroundWrapper 控制器，用于处理手势和与 ScrollView 的交互。
            /// Set up a scalable header background and overlay the HeaderBackgroundWrapper controller on top to handle gestures and interactions with the ScrollView.
            VStack(spacing: 0) {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(height: HEADER_IMAGE_HEIGHT)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .scaleEffect(scale, anchor: .top)
                
                Spacer().frame(height: profilePageModel.state.tabRowHeight)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .offset(y: contentOffsetY)
            }
            .overlay {
                HeaderBackgroundWrapper()
            }
            
            ZStack(alignment: .topLeading) {
                Image("arrow_left")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.black.opacity(0.2))
                    .clipShape(Circle())
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.top, geometryInfo.safeAreaInsets.top)
                    .padding(.leading, 12)
                    .offset(y: dismissButtonOffsetY)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .frame(width: geometryInfo.size.width, height: HEADER_IMAGE_HEIGHT + profilePageModel.state.tabRowHeight)
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Button("click me") {
                        print("clicked")
                    }
                    Text("XXX\(userId)")
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .frame(height: TOP_BAR_HEIGHT)
                
                PlainTabRow(
                    tabs: PageTab.allCases.map { $0.name },
                    pagingScrollViewProgress: $profilePageModel.state.pagingScrollViewProgress,
                    onTabSelected: onTabSelected
                )
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(
                                key: TabRowHeightPreferenceKey.self,
                                value: proxy.size.height
                            )
                    }
                }
            }
            .offset(y: contentOffsetY)
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(edges: .top)
        .onChange(of: profilePageModel.state.currentTab) { _, _ in
            withAnimation(.easeOut(duration: 0.2)) {
                scrollOffsetY = profilePageModel.state.currentVerticalOffset
            }
        }
        .onChange(of: profilePageModel.state.currentVerticalOffset) { _, newOffset in
            scrollOffsetY = newOffset
            
            print(String(
                format: "scrollOffsetY: %9.2f | backgroundOffsetY: %9.2f | contentOffsetY: %9.2f  |  dismissButtonOffsetY: %9.2f",
                scrollOffsetY,
                backgroundOffsetY,
                contentOffsetY,
                dismissButtonOffsetY
            ))
        }
        .offset(y: backgroundOffsetY)
    }
    
}
