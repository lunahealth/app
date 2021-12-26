import SwiftUI
import Selene

extension Home {
    struct Standard: View {
        @Binding var date: Date
        let moon: Moon
        let main: Main
        
        var body: some View {
            Info(date: $date, moon: moon)
                .padding(.top)
            Spacer()
            main
            Today(date: $date)
            Spacer()
        }
    }
}
