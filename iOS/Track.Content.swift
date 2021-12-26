import SwiftUI
import Selene

extension Track {
    struct Content: View {
        let day: Day
        
        var body: some View {
            ScrollView {
                Text(day.id, format: .dateTime.weekday().day())
                    .font(.title3)
            }
        }
    }
}
