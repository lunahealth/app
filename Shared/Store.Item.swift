import Foundation
import Selene

extension Store {
    enum Item: String, CaseIterable {
        case
        plus = "moonhealth.darkside"
        
        func purchased(active: Bool) async {
            if active {
                Defaults.isPremium = true
            } else {
                Defaults.isPremium = false
            }
        }
    }
}
