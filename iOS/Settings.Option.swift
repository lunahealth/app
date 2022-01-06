import SwiftUI

extension Settings {
    struct Option: View {
        let title: String
        let subtitle: String
        let symbol: String
        
        var body: some View {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                    .font(.body)
                + Text("\n" + subtitle)
                    .foregroundColor(.secondary)
                    .font(.footnote)
                Spacer()
                Image(systemName: symbol)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 4)
        }
    }
}
