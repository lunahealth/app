import SwiftUI
import Dater
import Selene

extension Cal {
    struct Header: View {
        @Binding var month: Int
        let calendar: [Days<Journal>]
        
        var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    
                    Button {
                        guard month > 0 else { return }
                        month -= 1
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 28).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.primary)
                            .frame(width: 40, height: 35)
                            .contentShape(Rectangle())
                    }
                    .opacity(month < 1 ? 0.4 : 1)

                    if !calendar.isEmpty, month < calendar.count, month >= 0 {
                        Text(Calendar.current.date(from: .init(year: calendar[month].year, month: calendar[month].month))!,
                             format: .dateTime.year().month(.wide))
                            .font(.callout.weight(.medium))
                            .foregroundStyle(.primary)
                            .frame(width: 220)
                    }
                    
                    Button {
                        guard month < calendar.count - 1 else { return }
                        month += 1
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 28).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.primary)
                            .frame(width: 40, height: 35)
                            .contentShape(Rectangle())
                    }
                    .opacity(month >= calendar.count - 1 ? 0.4 : 1)

                    Spacer()
                }
                .padding(.vertical, 10)
                Rectangle()
                    .fill(.tertiary)
                    .frame(height: 1)
            }
            .background(.ultraThinMaterial)
            .animation(.easeInOut(duration: 0.3), value: month)
        }
    }
}
