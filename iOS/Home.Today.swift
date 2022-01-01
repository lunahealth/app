import SwiftUI
import Selene

extension Home {
    struct Today: View {
        @Binding var date: Date
        
        var body: some View {
            Button {
                date = .now
            } label: {
                if !date.today {
                    Label("Today", systemImage: date < .now ? "arrow.forward" : "arrow.backward")
                        .font(.footnote)
                }
            }
            .buttonStyle(.bordered)
            .tint(.primary)
            .opacity(date.today ? 0 : 1)
            .frame(height: 40)
            .allowsHitTesting(!date.today)
        }
    }
}
