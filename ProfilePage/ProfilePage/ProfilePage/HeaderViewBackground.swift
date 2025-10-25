import UIKit
import SwiftUI

final class ForwardingHeaderView: UIView {
    var scrollViewProvider: (() -> UIScrollView?)?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isHidden || alpha == 0 || !isUserInteractionEnabled {
            return nil
        }
        
        if let sv = scrollViewProvider?() {
            let pointInScroll = convert(point, to: sv)
            if let hit = sv.hitTest(pointInScroll, with: event) {
                return hit
            } else {
                return sv
            }
        }
        
        return super.hitTest(point, with: event)
    }
}

class HeaderBackgroundViewController: UIViewController {
    var profilePageModel: ProfilePageModel!
    var forwardingView: ForwardingHeaderView!

    override func loadView() {
        forwardingView = ForwardingHeaderView()
        forwardingView.backgroundColor = .clear
        
        forwardingView.scrollViewProvider = { [weak self] in
            self?.profilePageModel.state.currentVerticalScrollView
        }
        
        self.view = forwardingView
    }
}

struct HeaderBackgroundWrapper: UIViewControllerRepresentable {
    @EnvironmentObject var profilePageModel: ProfilePageModel

    func makeUIViewController(context: Context) -> HeaderBackgroundViewController {
        let vc = HeaderBackgroundViewController()
        vc.profilePageModel = profilePageModel
        return vc
    }

    func updateUIViewController(_ uiViewController: HeaderBackgroundViewController, context: Context) {}
}
