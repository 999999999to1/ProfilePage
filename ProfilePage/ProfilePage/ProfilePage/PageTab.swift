import SwiftUI

enum PageTab: String, Hashable, CaseIterable, Identifiable {

    case like
    case collect
    case comment

    var id: String {
        rawValue
    }

    var name: String {
        switch self {
        case .like: "AAA"
        case .collect: "BBB"
        case .comment: "CCC"
        }
    }

}
