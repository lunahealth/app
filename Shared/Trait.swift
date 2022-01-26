import SwiftUI
import Selene

extension Trait: Comparable {
    public static func < (lhs: Trait, rhs: Trait) -> Bool {
        lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
    }
    
    var title: String {
        "\(self)".capitalized
    }
    
    var description: String {
        switch self {
        case .period:
            return "Track your menstrual bleeding"
        case .mood:
            return "Happy, sad or in between"
        case .sleep:
            return "How much sleep did you get"
        case .nutrition:
            return "Did you eat healthy"
        case .exercise:
            return "Did you move your body"
        case .focus:
            return "Were you able to focus"
        }
    }
    
    var symbol: String {
        switch self {
        case .exercise:
            return "bicycle"
        case .focus:
            return "aqi.medium"
        case .period:
            return "drop.fill"
        case .mood:
            return "theatermasks.fill"
        case .nutrition:
            return "fork.knife"
        case .sleep:
            return "bed.double.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .period:
            return .red
        case .mood:
            return .orange
        case .sleep:
            return .cyan
        case .nutrition:
            return .yellow
        case .exercise:
            return .mint
        case .focus:
            return .blue
        }
    }
}
