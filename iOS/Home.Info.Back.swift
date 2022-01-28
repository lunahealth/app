import SwiftUI

extension Home.Info {
    struct Back: View {
        @Binding var date: Date
        let text: Text
        let forward: Bool
        
        var body: some View {
            Button {
                date = .now
            } label: {
                HStack {
                    if forward {
                        text
                        Image(systemName: "arrow.forward")
                    } else {
                        Image(systemName: "arrow.backward")
                        text
                    }
                }
                .font(.callout)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.accentColor)
            .foregroundColor(.primary)
        }
    }
}
