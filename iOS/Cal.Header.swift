import SwiftUI
import Dater
import Selene

extension Cal {
    struct Header: View {
        @Binding var index: Int
        @Binding var selection: Int
        let calendar: [Days<Journal>]
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: 60)
                Spacer()
                
                Button {
                    guard index > 0 else { return }
                    index -= 1
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 24).weight(.light))
                        .frame(width: 45, height: 45)
                        .contentShape(Rectangle())
                }
                .opacity(index < 1 ? 0.3 : 1)

                if !calendar.isEmpty, index < calendar.count, index >= 0 {
                    Text(Calendar.current.date(from: .init(year: calendar[index].year, month: calendar[index].month))!,
                         format: .dateTime.year().month(.wide))
                        .font(.footnote)
                        .frame(width: 150)
                        .id(index)
                }
                
                Button {
                    guard index < calendar.count - 1 else { return }
                    index += 1
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 24).weight(.light))
                        .frame(width: 45, height: 45)
                        .contentShape(Rectangle())
                }
                .opacity(index >= calendar.count - 1 ? 0.3 : 1)
                
                Spacer()

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 14))
                        .frame(width: 45, height: 45)
                        .contentShape(Rectangle())
                        .foregroundColor(.secondary)
                }
            }
            .symbolRenderingMode(.hierarchical)
        }
    }
}
