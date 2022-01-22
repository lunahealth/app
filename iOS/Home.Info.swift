import SwiftUI
import Selene

extension Home {
    struct Info: View {
        @Binding var date: Date
        let moon: Moon
        
        var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 25).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 40, height: 50)
                    }
                    
                    VStack {
                        Text(date, format: .dateTime.weekday(.wide))
                        Text(verbatim: date.formatted(date: .numeric, time: .omitted))
                            .font(.footnote)
                    }
                    .frame(width: 140)
                    
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 25).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 40, height: 50)
                    }
                }
                if Calendar.current.isDateInToday(date) {
                    Text("Today")
                        .font(.footnote.weight(.light))
                        .frame(height: 36)
                } else {
                    Back(date: $date, text: offset, forward: date < .now)
                        .frame(height: 36)
                }
            }
            .padding(.top, 70)
        }
        
        private var offset: Text {
            if Calendar.current.isDate(date, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: .now)!) {
                return .init("Yesterday")
            } else if Calendar.current.isDate(date, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: .now)!) {
                return .init("Tomorrow")
            } else {
                return .init(date, format: .relative(presentation: .named, unitsStyle: .wide))
            }
        }
    }
}
