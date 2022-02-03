import SwiftUI
import Dater
import Selene

struct Cal: View, Equatable {
    weak var observatory: Observatory!
    @State private var month = 0
    @State private var calendar = [Days<Journal>]()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            if calendar.count > month {
                Ring(observatory: observatory,
                     month: calendar[month].items.flatMap { $0 })
                    .id(month)
            }
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.callout.weight(.medium))
                    .padding(.horizontal, 10)
                    .contentShape(Rectangle())
            }
            .tint(.accentColor)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            Spacer()
        }
        .animation(.easeInOut(duration: 0.4), value: month)
        .safeAreaInset(edge: .top, spacing: 0) {
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
        }
        .background(Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude))
        .task {
            let update = await cloud.model.calendar
            month = update.count - 1
            calendar = update
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
