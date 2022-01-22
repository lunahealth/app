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
                ZStack {
                    Capsule()
                        .fill(Color.accentColor.opacity(0.5))
                    HStack {
                        if forward {
                            text
                            Image(systemName: "arrow.forward")
                        } else {
                            Image(systemName: "arrow.backward")
                            text
                        }
                    }
                    .font(.footnote.weight(.light))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 6)
                    .padding(5)
                }
                .fixedSize()
                .contentShape(Rectangle())
            }
        }
    }
}
