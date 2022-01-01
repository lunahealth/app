import SwiftUI
import Selene

extension Home {
    struct Standard: View {
        @Binding var date: Date
        let moon: Moon
        let main: Main
        
        var body: some View {
            Spacer()
            Info(date: $date, moon: moon)
            main
            Today(date: $date)
                .padding(.bottom, 40)
        }
    }
}
