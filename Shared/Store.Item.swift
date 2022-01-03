import Foundation
import UserNotifications
import Selene

extension Store {
    enum Item: String, CaseIterable {
        case
        plus = "moonhealth.plus"
        
        func purchased(active: Bool) async {
            if active {
                Defaults.isPremium = true
                await UNUserNotificationCenter.send(message: "Moon Health + purchase successful!")
            } else {
                Defaults.isPremium = false
            }
        }
    }
}
