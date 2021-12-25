import SwiftUI
import Selene

extension Home {
    struct Standard: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
        let moon: Moon
        
        var body: some View {
            Info(date: $date, moon: moon)
                .padding(.top)
            Spacer()
            Main(date: $date, wheel: $wheel, moon: moon)
//                .padding(.horizontal)
            Today(date: $date)
            Spacer()
        }
    }
}
