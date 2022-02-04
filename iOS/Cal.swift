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
                    .equatable()
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
            .padding(.bottom, 30)
        }
        .animation(.easeInOut(duration: 0.5), value: month)
        .safeAreaInset(edge: .top, spacing: 0) {
            Header(month: $month, calendar: calendar)
        }
        .background(Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude))
        .onReceive(cloud) {
            calendar = $0.calendar
            month = calendar.count - 1
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
