import SwiftUI
import Selene

extension Home {
    struct Info: View {
        @Binding var date: Date
        let moon: Moon
        
        var body: some View {
            HStack(spacing: 0) {
                Button {
                    date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? .now
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 30).weight(.light))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.primary, Color.accentColor.opacity(0.3))
                        .frame(width: 40, height: 50)
                        .contentShape(Rectangle())
                }
                
                if Calendar.current.isDateInToday(date) {
                    Text("Today")
                        .font(.body.weight(.medium))
                        .frame(maxWidth: .greatestFiniteMagnitude)
                } else {
                    Button(date.offset) {
                        date = .now
                    }
                    .font(.callout)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .tint(.accentColor)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .greatestFiniteMagnitude)
                }
                
                Button {
                    date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? .now
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 30).weight(.light))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.primary, Color.accentColor.opacity(0.3))
                        .frame(width: 40, height: 50)
                        .contentShape(Rectangle())
                }
            }
        }
    }
}
