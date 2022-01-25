import SwiftUI
import Selene

extension Home {
    struct Info: View {
        @Binding var date: Date
        let moon: Moon
        
        var body: some View {
            VStack(spacing: 0) {
                Detail(moon: moon, date: date)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .padding(.bottom)
                
                HStack(spacing: 0) {
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 25).weight(.light))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.primary, Color.accentColor.opacity(0.3))
                            .frame(width: 40, height: 50)
                    }
                    
                    if Calendar.current.isDateInToday(date) {
                        Text("Today")
                            .font(.body.weight(.medium))
                            .frame(maxWidth: .greatestFiniteMagnitude)
                    } else {
                        Back(date: $date, text: offset, forward: date < .now)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                    }
                    
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 25).weight(.light))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.primary, Color.accentColor.opacity(0.3))
                            .frame(width: 40, height: 50)
                    }
                }
                Spacer()
            }
            .frame(width: 220)
            .padding(.top, 60)
        }
        
        private var offset: Text {
            if Calendar.current.isDate(date, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: .now)!) {
                return .init("yesterday")
            } else if Calendar.current.isDate(date, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: .now)!) {
                return .init("tomorrow")
            } else {
                return .init(date, format: .relative(presentation: .named, unitsStyle: .wide))
            }
        }
    }
}
