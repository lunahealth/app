import SwiftUI
import Dater
import Selene

struct Cal: View, Equatable {
    weak var observatory: Observatory!
    @State private var month = 0
    @State private var calendar = [Days<Journal>]()
    
    var body: some View {
        Content(observatory: observatory, month: month, calendar: calendar)
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
