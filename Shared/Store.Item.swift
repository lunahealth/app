import Foundation
import UserNotifications
import Selene

extension Store {
    enum Item: String, CaseIterable {
        case
        plus = "moonhealth.darkside"
        
        func purchased(active: Bool) async {
            if active {
                Defaults.isPremium = true
                await UNUserNotificationCenter.send(message: "The Dark Side of the Moon purchase successful!")
            } else {
                Defaults.isPremium = false
            }
        }
    }
}
