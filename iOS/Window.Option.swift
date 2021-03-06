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
                        .font(.system(size: 22).weight(.medium))
                        .frame(height: 30)
                    Text(title)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                .tint(.white)
                .frame(width: 74)
                .contentShape(Rectangle())
            }
        }
    }
}
