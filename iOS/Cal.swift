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
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: 42)
                Spacer()
                
                Button {
                    month -= 1
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 28).weight(.light))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.primary, Color.accentColor.opacity(0.3))
                        .frame(width: 40, height: 35)
                        .padding(.top, 10)
                        .contentShape(Rectangle())
                }
                .disabled(month < 1)
                .opacity(month < 1 ? 0.3 : 1)

                if !calendar.isEmpty, month < calendar.count, month >= 0 {
                    Text(Calendar.current.date(from: .init(year: calendar[month].year, month: calendar[month].month))!,
                         format: .dateTime.year().month(.wide))
                        .font(.callout.weight(.medium))
                        .foregroundStyle(.secondary)
                        .frame(width: 170)
                        .padding(.top, 10)
                }
                
                Button {
                    month += 1
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 28).weight(.light))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.primary, Color.accentColor.opacity(0.3))
                        .frame(width: 40, height: 35)
                        .padding(.top, 10)
                        .contentShape(Rectangle())
                }
                .disabled(month >= calendar.count - 1)
                .opacity(month >= calendar.count - 1 ? 0.3 : 1)

                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30).weight(.light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.secondary)
                        .frame(width: 32, height: 36)
                        .padding([.top, .trailing], 10)
                        .contentShape(Rectangle())
                }
            }
            Spacer()
            if let month = calendar.last {
                Ring(observatory: observatory, month: month.items.flatMap { $0 })
            }
            Spacer()
        }
        .background(Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude))
        .task {
            let update = await cloud.model.calendar
            let month = update.count - 1
            calendar = update
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
