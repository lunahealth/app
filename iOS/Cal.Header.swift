import SwiftUI
import Dater
import Selene

extension Cal {
    struct Header: View {
        @Binding var index: Int
        let calendar: [Days<Journal>]
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            HStack(alignment: .top, spacing: 0) {
                Spacer()
                    .frame(width: 45)
                
                Spacer()
                
                Button {
                    guard index > 0 else { return }
                    index -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                        .frame(width: 40, height: 60)
                        .contentShape(Rectangle())
                }
                .opacity(index < 1 ? 0.2 : 1)

                if !calendar.isEmpty, index < calendar.count, index >= 0 {
                    Text(Calendar.current.date(from: .init(year: .init(calendar[index].year), month: .init(calendar[index].month)))!,
                         format: .dateTime.year().month(.wide))
                        .font(.body)
                        .frame(width: 170, height: 60)
                        .id(index)
                }
                
                Button {
                    guard index < calendar.count - 1 else { return }
                    index += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                        .frame(width: 40, height: 60)
                        .contentShape(Rectangle())
                }
                .opacity(index >= calendar.count - 1 ? 0.2 : 1)
                
                Spacer()

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16))
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                        .foregroundColor(.secondary)
                }
            }
            .background(Color(.tertiarySystemBackground))
        }
    }
}
