import SwiftUI
import Selene

extension Trait {
    var title: String {
        "\(self)".capitalized
    }
    
    var description: String {
        switch self {
        case .period:
            return "Discharge during your menstrual cycle"
        case .mood:
            return "Happy, sad or in between"
        case .sleep:
            return "How much sleep you get at night"
        case .nutrition:
            return "How weel you eat"
        case .workout:
            return "How much excercise"
        case .walk:
            return "How much you walk"
        case .focus:
            return "Are you able to focus"
        case .water:
            return "How much water you drink"
        case .work:
            return "How long you work"
        case .eat:
            return "How much you eat"
        case .sweets:
            return "How much indulgement"
        case .drink:
            return "Alcoholic drinks"
        case .smoke:
            return "Cigarettes"
        case .cramps:
            return "Muscle contractions"
        case .online:
            return "How much screen time"
        case .pms:
            return "Premenstrual syndromes"
        }
    }
    
    var low: String {
        switch self {
        case .workout:
            return "Nothing"
        case .nutrition:
            return "Junk food"
        case .sleep:
            return "No sleep"
        case .mood:
            return "Sad"
        case .period:
            return "None"
        default:
            return "Low"
        }
    }
    
    var high: String {
        switch self {
        case .workout:
            return "Too much"
        case .nutrition:
            return "Healthy"
        case .sleep:
            return "Too much"
        case .mood:
            return "Happy"
        case .period:
            return "A lot"
        default:
            return "High"
        }
    }
    
    var image: String {
        "Trait.\(self)"
    }
    
    var color: Color {
        switch self {
        case .period:
            return .red
        case .mood:
            return .orange
        case .sleep:
            return .indigo
        case .nutrition:
            return .yellow
        case .workout:
            return .green
        default:
            return .blue
        }
    }
}
