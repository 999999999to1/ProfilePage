# ProfilePage

<a href="https://github.com/999999999to1/ProfilePage/raw/main/ProfilePage/horizontal_swipe.gif">
  <img src="https://github.com/999999999to1/ProfilePage/raw/main/ProfilePage/horizontal_swipe.gif" alt="横向分页动画" width="200">
</a>

<a href="https://github.com/999999999to1/ProfilePage/raw/main/ProfilePage/scroll_down.gif">
  <img src="https://github.com/999999999to1/ProfilePage/raw/main/ProfilePage/scroll_down.gif" alt="向下滚动效果" width="200">
</a>

<a href="https://github.com/999999999to1/ProfilePage/raw/main/ProfilePage/scroll_up.gif">
  <img src="https://github.com/999999999to1/ProfilePage/raw/main/ProfilePage/scroll_up.gif" alt="向上滚动效果" width="200">
</a>

这是一个 **尝试用 SwiftUI 与 UIKit 混合实现的用户个人主页组件**，主要用于个人信息展示和多图内容浏览。设计上尽量考虑了交互流畅性和视觉效果，适合社交应用、个人主页或相册展示场景。

---

## 功能

- **横向分页**：在多个内容页之间平滑滑动，支持分页动画。  
- **多图列表**：用户可以浏览头像、相册或其他图片集合，支持简单的缩放和滑动浏览。  
- **可伸缩头部**：顶部区域根据滚动自动伸缩，尽量实现流畅的视觉过渡。  
- **Header 高度过渡**：随着内容滚动，Header 高度动态变化，效果尽可能自然。  
- **Tab 切换动画**：底部或顶部 Tab 切换时，内容与动画尝试做到无缝衔接。  
- **垂直滚动偏移管理**：支持列表和内容视图的同步滚动，保证 Header 和 Tab 的联动效果。  
- **SwiftUI 与 UIKit 混合使用**：尝试结合 SwiftUI 的声明式布局和 UIKit 的可控性，处理一些复杂 UI 场景。
- 手势返回。

---

## 技术亮点（尝试实现的）

- SwiftUI 声明式布局用于快速构建内容视图  
- UIKit 控制滚动，实现 Header 伸缩和分页动画  
- 多图浏览、横向分页和垂直滚动同步  
- 尽量保持组件可复用和易于扩展  

---

## 使用场景

- 个人主页（Profile Page）  
- 社交应用的用户信息展示页  
- 图片/相册浏览组件  
- 任意需要 Header 可伸缩、分页内容和 Tab 切换的复杂列表页面  

---




This is an **attempt at a user profile page component implemented with a mix of SwiftUI and UIKit**, mainly for displaying personal information and browsing multiple images. The design tries to consider smooth interactions and visual effects, making it suitable for social apps, personal profiles, or photo gallery pages.

---

## Features

- **Horizontal paging**: Smoothly swipe between multiple content pages with paging animations.  
- **Multiple image lists**: Users can browse avatars, photo albums, or other image collections, supporting simple zoom and swipe interactions.  
- **Expandable header**: The top area automatically expands or collapses based on scrolling, aiming for a smooth visual transition.  
- **Header height transition**: The header height dynamically changes with scrolling to achieve as natural an effect as possible.  
- **Tab switch animations**: Content and animations try to transition seamlessly when switching tabs at the top or bottom.  
- **Vertical scroll offset management**: Synchronizes scrolling between lists and content views to ensure linked header and tab behavior.  
- **SwiftUI and UIKit hybrid**: Attempts to combine SwiftUI’s declarative layout with UIKit’s controllability to handle more complex UI scenarios.  
- **Gesture-based back navigation**.

---

## Technical Highlights (attempted)

- SwiftUI declarative layout for quickly building content views  
- UIKit-based scroll control to implement header expansion and paging animations  
- Multi-image browsing, horizontal paging, and vertical scroll synchronization  
- Strives to keep the component reusable and easily extendable  

---

## Use Cases

- Personal profile pages  
- User information pages in social apps  
- Photo/album browsing components  
- Any complex list page requiring expandable headers, paged content, and tab switching
