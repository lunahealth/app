import SwiftUI
import Selene

extension Home.Info {
    struct Detail: View {
        let moon: Moon
        let date: Date
        
        var body: some View {
            Text(moon.fraction, format: .number)
                .font(.title.weight(.medium).monospacedDigit())
            + Text("%")
                .font(.caption)
            + Text("\n")
            + Text(moon.phase.name)
                .font(.footnote)
            + Text("\n")
            + Text(date, format: .dateTime.year(.defaultDigits).month(.defaultDigits).day(.defaultDigits).weekday(.wide))
                .font(.callout)
        }
    }
}
