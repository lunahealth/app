import SwiftUI
import Dater
import Selene

struct Cal: View {
    weak var observatory: Observatory!
    @State private var calendar = [Days<Journal>]()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 50)
                Spacer()
                
                if let month = calendar.last {
                    Text(Calendar.current.date(from: .init(year: month.year, month: month.month))!,
                         format: .dateTime.year().month(.wide))
                        .font(.footnote)
                }
                
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30).weight(.light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.secondary)
                        .frame(width: 50, height: 55)
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
            calendar = await cloud.model.calendar
        }
    }
}
