import SwiftUI
import Selene

extension Home {
    struct Compact: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
        let moon: Moon
        
        var body: some View {
            HStack {
                VStack {
                    Info(date: $date, moon: moon)
                    Today(date: $date)
                }
                .frame(width: 250)
                Main(date: $date, wheel: $wheel, moon: moon)
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
        }
    }
}
