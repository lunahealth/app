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
                VStack(spacing: 4) {
                    Image(systemName: symbol)
                        .font(.system(size: 22))
                        .frame(height: 25)
                    Text(title)
                        .font(.system(size: 11))
                }
                .tint(.primary)
                .frame(width: 74)
                .contentShape(Rectangle())
            }
        }
    }
}
