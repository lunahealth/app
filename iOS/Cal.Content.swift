import SwiftUI
import Selene
import Dater

extension Cal {
    struct Content: View {
        @Binding var selection: Int
        let observatory: Observatory
        let month: Int
        let calendar: [Days<Journal>]
        @State private var detail = false
        
        var body: some View {
            VStack(spacing: 0) {
                if detail {
                    Month(selection: $selection,
                          detail: $detail,
                          observatory: observatory,
                          month: calendar[month].items.flatMap { $0 }.filter { $0.content.date <= .now })
                } else {
                    Spacer()
                    if calendar.count > month {
                        Ring(selection: $selection,
                             detail: $detail,
                             observatory: observatory,
                             month: calendar[month].items.flatMap { $0 })
                    }
                    Spacer()
                }
            }
            .animation(.easeInOut(duration: 1), value: detail)
        }
    }
}
