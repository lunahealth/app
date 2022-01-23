import SwiftUI
import Selene

extension Trait {
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
    
    var low: String {
        switch self {
        case .exercise:
            return "Nothing"
        case .nutrition:
            return "Junk food"
        case .sleep:
            return "No sleep"
        case .mood:
            return "Sad"
        case .period:
            return "None"
        case .focus:
            return "Unable"
        }
    }
    
    var high: String {
        switch self {
        case .exercise:
            return "Too much"
        case .nutrition:
            return "Healthy"
        case .sleep:
            return "Too much"
        case .mood:
            return "Happy"
        case .period:
            return "A lot"
        case .focus:
            return "On the zone"
        }
    }
    
    var image: String {
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
