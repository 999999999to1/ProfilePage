import SwiftUI

@MainActor
class ProfilePageModel: ObservableObject {
    
    struct State: Equatable {
        var currentTab: PageTab = .like
        var tabRowHeight: CGFloat = 0
        var horizontalScrollOffset: CGFloat = 0
        
        /// 每个 tab 对应的垂直滚动偏移
        /// The vertical scroll offset corresponding to each tab
        var verticalScrollOffsets: [PageTab: CGFloat] = [:]
        
        /// 获取当前 tab 的偏移量（没有则为 0）
        /// Get the current tab’s offset (0 if none)
        var currentVerticalOffset: CGFloat {
            verticalScrollOffsets[currentTab] ?? 0
        }
        
        var verticalScrollViews: [PageTab: UIScrollView] = [:]
        var currentVerticalScrollView: UIScrollView? {
            verticalScrollViews[currentTab] ?? nil
        }
        
        var pagingScrollViewProgress: CGFloat = 0
    }
    
    @Published var state: State
    
    init() {
        _state = Published(
            wrappedValue: State()
        )
    }
    
    func tabRowHeightChanged(_ height: CGFloat) {
        state.tabRowHeight = height
    }
    
    func verticalScrollOffsetChanged(_ offset: CGFloat, tab: PageTab) {
        state.verticalScrollOffsets[tab] = offset - state.tabRowHeight - HEADER_IMAGE_HEIGHT
    }
    
    func horizontalScrollOffsetChanged(_ offset: CGFloat) {
        state.horizontalScrollOffset = offset
        let index = Int((offset / UIScreen.main.bounds.width).rounded())
        if PageTab.allCases.indices.contains(index) {
            state.currentTab = PageTab.allCases[index]
        }
        let progress = offset / UIScreen.main.bounds.width
        state.pagingScrollViewProgress = progress
    }
    
    func verticalScrollViewChanged(_ scrollView: UIScrollView, tab: PageTab) {
        if state.verticalScrollViews[tab] === scrollView { return }
        state.verticalScrollViews[tab] = scrollView
    }
}
