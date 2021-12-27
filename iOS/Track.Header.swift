import SwiftUI
import Selene

extension Track {
    struct Header: View, Equatable {
        @Binding var date: Date
        let week: [Day]
        
        var body: some View {
            HStack(spacing: 0) {
                ForEach(week) { day in
                    Button {
                        date = day.id
                    } label: {
                        Option(day: day,
                               current: Calendar.current.isDate(date, inSameDayAs: day.id))
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .frame(maxWidth: 520)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            true
        }
    }
}
