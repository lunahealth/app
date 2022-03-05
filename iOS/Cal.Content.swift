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
        @Namespace private var animation
        
        var body: some View {
            VStack(spacing: 0) {
                if detail {
                    Month(selection: $selection,
                          detail: $detail,
                          observatory: observatory,
                          month: calendar[month].items.flatMap { $0 }.filter { $0.content.date <= .now },
                          animation: animation)
                } else {
                    Spacer()
                    if calendar.count > month {
                        Ring(selection: $selection,
                             detail: $detail,
                             observatory: observatory,
                             month: calendar[month].items.flatMap { $0 })
                            .matchedGeometryEffect(id: "calendar", in: animation)
                    }
                    Spacer()
                }
            }
            .animation(.easeInOut(duration: 0.35), value: detail)
        }
    }
}
