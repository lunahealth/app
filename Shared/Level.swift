import Selene

extension Level {
    var symbol: String {
        switch self {
        case .bottom:
            return "minus"
        case .low:
            return "chevron.down"
        case .medium:
            return "alternatingcurrent"
        case .high:
            return "chevron.up"
        case .top:
            return "arrow.up"
        }
    }
    
    func title(for trait: Trait) -> String {
        switch self {
        case .bottom:
            switch trait {
            case .exercise:
                return "None"
            case .focus:
                return "None"
            case .period:
                return "None"
            case .mood:
                return "None"
            case .nutrition:
                return "None"
            case .sleep:
                return "None"
            }
        case .low:
            switch trait {
            case .exercise:
                return "Little"
            case .focus:
                return "Little"
            case .period:
                return "Little"
            case .mood:
                return "Little"
            case .nutrition:
                return "Little"
            case .sleep:
                return "Little"
            }
        case .medium:
            switch trait {
            case .exercise:
                return "Some"
            case .focus:
                return "Some"
            case .period:
                return "Some"
            case .mood:
                return "Some"
            case .nutrition:
                return "Some"
            case .sleep:
                return "Some"
            }
        case .high:
            switch trait {
            case .exercise:
                return "Decent"
            case .focus:
                return "Decent"
            case .period:
                return "Decent"
            case .mood:
                return "Decent"
            case .nutrition:
                return "Decent"
            case .sleep:
                return "Decent"
            }
        case .top:
            switch trait {
            case .exercise:
                return "A lot"
            case .focus:
                return "A lot"
            case .period:
                return "A lot"
            case .mood:
                return "A lot"
            case .nutrition:
                return "A lot"
            case .sleep:
                return "A lot"
            }
        }
    }
}
