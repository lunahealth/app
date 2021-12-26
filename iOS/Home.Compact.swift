import SwiftUI
import Selene

extension Home {
    struct Compact: View {
        @Binding var date: Date
        let moon: Moon
        let main: Main
        
        var body: some View {
            HStack {
                VStack {
                    Info(date: $date, moon: moon)
                    Today(date: $date)
                }
                .frame(width: 250)
                main
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
        }
    }
}
