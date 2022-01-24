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
                return "Nothing"
            case .mood:
                return "Very low"
            case .nutrition:
                return "Worst"
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
                return "Low"
            case .nutrition:
                return "Bad"
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
                return "Regular"
            case .mood:
                return "Indifferent"
            case .nutrition:
                return "Regular"
            case .sleep:
                return "Enough"
            }
        case .high:
            switch trait {
            case .exercise:
                return "Decent"
            case .focus:
                return "Much"
            case .period:
                return "Much"
            case .mood:
                return "Happy"
            case .nutrition:
                return "Good"
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
                return "Hyped"
            case .nutrition:
                return "Best"
            case .sleep:
                return "A lot"
            }
        }
    }
}
