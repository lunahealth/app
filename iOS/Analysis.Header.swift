import SwiftUI
import Selene

extension Analysis {
    struct Header: View {
        let trait: Trait
        
        var body: some View {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor.opacity(0.2))
                    HStack {
                        Image(systemName: trait.symbol)
                            .font(.system(size: 14).weight(.light))
                        Text(trait.title)
                            .font(.callout.weight(.medium))
                    }
                    .foregroundColor(.accentColor)
                }
                .frame(height: 38)
                HStack(spacing: 20) {
                    ForEach(Level.allCases, id: \.self) { level in
                        VStack(spacing: 0) {
                            Image(systemName: level.symbol)
                                .font(.system(size: 13))
                                .frame(width: 26, height: 26)
                            Text(level.title(for: trait))
                                .font(.caption)
                        }
                    }
                }
                .foregroundStyle(.secondary)
                .foregroundColor(.primary)
            }
            .padding(.vertical, 5)
        }
    }
}
