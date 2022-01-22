import SwiftUI

extension Window {
    struct Option: View {
        @Binding var active: Bool
        let title: String
        let symbol: String
        
        var body: some View {
            Button {
                active = true
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: symbol)
                        .font(.system(size: 20).weight(.light))
                        .frame(height: 28)
                    Text(title)
                        .font(.system(size: 9))
                }
                .foregroundColor(.primary)
                .frame(width: 70)
                .contentShape(Rectangle())
            }
        }
    }
}
