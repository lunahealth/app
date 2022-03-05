import SwiftUI
import Selene
import Dater

extension Cal {
    struct Content: View {
        weak var observatory: Observatory!
        let month: Int
        let calendar: [Days<Journal>]
        
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
            }
        }
    }
}
