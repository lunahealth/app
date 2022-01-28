import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Item: View {
        let day: Days<Journal>.Item
        
        var body: some View {
            VStack {
                Text(day.content.date, format: .dateTime)
                Spacer()
            }
        }
    }
}
