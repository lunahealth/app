import SwiftUI
import Selene

extension Home {
    struct Info: View {
        @Binding var date: Date
        let moon: Moon
        
        var body: some View {
            HStack(spacing: 20) {
                Button {
                    date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? .now
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 32).weight(.light))
                        .symbolRenderingMode(.hierarchical)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.primary)
                }

                VStack {
                    Text(date, format: .dateTime.weekday(.wide))
                    Text(verbatim: date.formatted(date: .numeric, time: .omitted))
                    if Calendar.current.isDateInToday(date) {
                        Text("Today")
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .frame(height: 26)
                    } else {
                        Back(date: $date, text: offset, forward: date < .now)
                            .frame(height: 26)
                    }
                }
                .frame(width: 150)
                
                Button {
                    date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? .now
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 32).weight(.light))
                        .symbolRenderingMode(.hierarchical)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.primary)
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
