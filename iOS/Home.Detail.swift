import SwiftUI
import Selene

extension Home {
    struct Detail: View {
        let observatory: Observatory
        let moon: Moon
        let date: Date
        @State private var calendar = false
        
        var body: some View {
            HStack {
                Text(moon.fraction, format: .number)
                    .font(.title.weight(.medium).monospacedDigit())
                + Text("% ")
                    .font(.caption)
                + Text(moon.phase.name)
                    .font(.footnote)
                + Text("\n")
                + Text(date, format: .dateTime.year(.defaultDigits).month(.wide).day(.defaultDigits).weekday(.wide))
                    .font(.callout)
                Spacer()
                
                Button {
                    calendar = true
                } label: {
                    Image(systemName: "calendar")
                        .font(.system(size: 22))
                        .tint(.primary)
                        .foregroundStyle(.secondary)
                        .frame(width: 40, height: 40)
                        .contentShape(Rectangle())
                }
                .sheet(isPresented: $calendar) {
                    Cal(observatory: observatory)
                        .equatable()
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
    }
}
