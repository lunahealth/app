import SwiftUI
import Selene

extension Home {
    struct Detail: View {
        let observatory: Observatory
        let moon: Moon
        let date: Date
        let track: Bool
        @State private var calendar = false
        @State private var completed = false
        
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
                        .font(.system(size: 22).weight(.light))
                        .tint(.primary)
                        .frame(width: 40, height: 40)
                        .contentShape(Rectangle())
                }
                .opacity(track ? 0 : 1)
                .animation(.easeInOut(duration: 0.3), value: track)
                .sheet(isPresented: $calendar) {
                    Cal(observatory: observatory)
                        .equatable()
                }
                
                if track && completed {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 30).weight(.light))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .onReceive(cloud) {
                let traits = $0.settings.traits
                let journal = $0[.now]
                completed = !traits.isEmpty && traits.count <= (journal?.traits.count ?? 0)
            }
        }
    }
}
