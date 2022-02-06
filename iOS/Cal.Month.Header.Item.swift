import SwiftUI
import Dater
import Selene

extension Cal.Month.Header {
    struct Item: View {
        @Binding var selection: Int
        let day: Days<Journal>.Item
        let moon: Moon
        
        var body: some View {
            VStack(spacing: 2) {
                Text(day.today ? "Today" : " ")
                    .font(.caption2)
                    .tint(.primary)
                    .foregroundStyle(selection == day.value ? .primary : .secondary)
                ZStack {
                    if selection == day.value {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.accentColor.opacity(0.3))
                    }
                    VStack {
                        Canvas { context, size in
                            context.draw(moon: moon,
                                         image: .init("MoonSmall"),
                                         shadow: .init("ShadowSmall"),
                                         radius: 18,
                                         center: .init(x: 18, y: 18))
                        }
                        .frame(width: 36, height: 36)
                        .opacity(selection == day.value ? 1 : 0.6)
                        Text(day.content.date, format: .dateTime.weekday(.short).day())
                            .font(.footnote)
                            .tint(.primary)
                            .foregroundStyle(selection == day.value ? .primary : .secondary)
                        Text(day.content.date, format: .dateTime.month(.abbreviated))
                            .font(.footnote)
                            .tint(.primary)
                            .foregroundStyle(selection == day.value ? .primary : .secondary)
                    }
                }
                .frame(width: 66, height: 100)
                .contentShape(Rectangle())
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.35)) {
                    selection = day.value
                }
            }
        }
    }
}
