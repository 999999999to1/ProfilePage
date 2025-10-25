import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBarsOnSwipe = false
        setupFullWidthPopGesture()
    }
    private func setupFullWidthPopGesture() {
        guard let systemPopGesture = self.interactivePopGestureRecognizer,
              let gestureView = systemPopGesture.view else {
            return
        }

        let fullScreenPopGesture = UIPanGestureRecognizer()
        fullScreenPopGesture.delegate = self
        gestureView.addGestureRecognizer(fullScreenPopGesture)

        let internalTargets = systemPopGesture.value(forKey: "_targets") as? [NSObject]
        if let internalTarget = internalTargets?.first,
           let target = internalTarget.value(forKey: "target") {
            let action = Selector(("handleNavigationTransition:"))
            fullScreenPopGesture.addTarget(target, action: action)
        }
    }
        
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let scrollView = findScrollView(from: gestureRecognizer.view){
            if let pan = gestureRecognizer as? UIPanGestureRecognizer {
                let translation = pan.translation(in: scrollView)
                if scrollView.contentOffset.x <= 0 && translation.x > 0 {
                    scrollView.panGestureRecognizer.isEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak scrollView] in
                        guard let scrollView = scrollView else { return }
                        scrollView.panGestureRecognizer.isEnabled = true
                    }
                }
            }
        }
        
        let isSystemSwipeToBackEnabled = interactivePopGestureRecognizer?.isEnabled == true
        let isThereStackedViewControllers = viewControllers.count > 1
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: self.view)
            if translation.x > 0 {
                return isSystemSwipeToBackEnabled && isThereStackedViewControllers
            }
            return false
        }
        return false
    }
    
    private func findScrollView(from view: UIView?) -> UIScrollView? {
        guard let view = view else { return nil }

        if let scroll = view as? UIScrollView {
            if scroll.accessibilityIdentifier == HORIZONTAL_SCROLLVIEW_IDENTIFIER {
                return scroll
            }
        }

        var superview = view.superview
        while let current = superview {
            if let scroll = current as? UIScrollView {
                if scroll.accessibilityIdentifier == HORIZONTAL_SCROLLVIEW_IDENTIFIER {
                    return scroll
                }
            }
            superview = current.superview
        }

        return findScrollViewInSubviews(view)
    }

    private func findScrollViewInSubviews(_ view: UIView) -> UIScrollView? {
        for subview in view.subviews {
            if let scroll = subview as? UIScrollView {
                if scroll.accessibilityIdentifier == HORIZONTAL_SCROLLVIEW_IDENTIFIER {
                    return scroll
                }
            } else if let scroll = findScrollViewInSubviews(subview) {
                if scroll.accessibilityIdentifier == HORIZONTAL_SCROLLVIEW_IDENTIFIER {
                    return scroll
                }
            }
        }
        return nil
    }
}
