import Selene

extension Moon.Phase {
    var name: String {
        switch self {
        case .new:
            return "New Moon"
        case .waxingCrescent:
            return "Waxing Crescent"
        case .firstQuarter:
            return "First Quarter"
        case .waxingGibbous:
            return "Waxing Gibbous"
        case .full:
            return "Full Moon"
        case .waningGibbous:
            return "Waning Gibbous"
        case .lastQuarter:
            return "Last Quarter"
        case .waningCrescent:
            return "Waning Crescent"
        }
    }
}
