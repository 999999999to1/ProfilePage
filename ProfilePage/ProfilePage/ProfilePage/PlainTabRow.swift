import SwiftUI

struct PlainTabRow: View {
    @EnvironmentObject var geometryInfo: GeometryInfo
    @State private var selectedIndex = 0
    @State private var tabFrames: [CGRect] = []
    
    var tabs: [String]
    @Binding var pagingScrollViewProgress: CGFloat
    var onTabSelected: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                ForEach(tabs.indices, id: \.self) { index in
                    let isSelected = index == selectedIndex
                    Button(action: {
                        if selectedIndex != index {
                            selectedIndex = index
                            onTabSelected(selectedIndex)
                        }
                    }) {
                        Text(tabs[index])
                            .foregroundColor(isSelected ? Color.black : Color.gray)
                            .font(.system(size: 16, weight: isSelected ? .bold : .regular))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                    }
                    .contentShape(Rectangle())
                    .background(
                        GeometryReader { geo in
                            Color.clear
                                .anchorPreference(key: TabPreferenceKey.self, value: .bounds) {
                                    [TabPreferenceData(index: index, bounds: $0)]
                                }
                        }
                    )
                    .animation(.easeInOut(duration: 0.1), value: isSelected)
                }
                
                Spacer()
            }
            
            ZStack(alignment: .bottomLeading) {
                Divider()
                    .frame(height: 0.5)
                
                if tabFrames.isEmpty {
                    EmptyView()
                } else {
                    let lower = min(max(Int(floor(pagingScrollViewProgress)), 0), tabFrames.count - 1)
                    let upper = min(max(Int(ceil(pagingScrollViewProgress)), 0), tabFrames.count - 1)
                    let progress = pagingScrollViewProgress - CGFloat(Int(floor(pagingScrollViewProgress)))

                    let lowerFrame = tabFrames[lower]
                    let upperFrame = tabFrames[upper]
                    
                    let interpolatedX = lowerFrame.minX + (upperFrame.minX - lowerFrame.minX) * progress
                    let interpolatedWidth = lowerFrame.width + (upperFrame.width - lowerFrame.width) * progress
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: interpolatedWidth, height: 2)
                        .offset(x: interpolatedX, y: 0)
                }
            }
            .frame(height: 2)
            .animation(.easeInOut(duration: 0.2), value: pagingScrollViewProgress)
        }
        .onChange(of: pagingScrollViewProgress) { oldValue, newValue in
            let newIndex = Int(round(newValue))
            if newIndex != selectedIndex, newIndex >= 0, newIndex < tabs.count {
                selectedIndex = newIndex
            }
        }
        .overlayPreferenceValue(TabPreferenceKey.self) { prefs in
            GeometryReader { proxy in
                Color.clear.onAppear {
                    tabFrames = prefs.sorted { $0.index < $1.index }.map { data in
                        proxy[data.bounds]
                    }
                }
            }
        }
    }
}
