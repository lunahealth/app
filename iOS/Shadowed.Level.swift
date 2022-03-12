extension Shadowed {
    enum Level {
        case
        minimum,
        medium,
        maximum
        
        var radius: Double {
            switch self {
            case .minimum:
                return 3
            case .medium:
                return 4
            case .maximum:
                return 5
            }
        }
        
        var light: Double {
            switch self {
            case .minimum:
                return 0.15
            case .medium:
                return 0.4
            case .maximum:
                return 0.55
            }
        }
    }
}
