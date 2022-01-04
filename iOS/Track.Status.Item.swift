import Foundation
import Selene

extension Track.Status {
    struct Item: Identifiable {
        var active: Bool
        var value: Double
        let id: Trait
    }
}
