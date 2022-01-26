import SwiftUI
import Selene
/*
extension TrackOld {
    struct Header: View {
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
            .padding(.bottom)
            .padding(.horizontal, 20)
            .frame(maxWidth: 520)
            Rectangle()
                .foregroundColor(.init(.tertiaryLabel))
                .frame(height: 1)
                .ignoresSafeArea(edges: .all)
        }
    }
}
*/
