import SwiftUI
import Selene

extension Analysis {
    struct Header: View {
        let trait: Trait
        
        var body: some View {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor.opacity(0.4))
                    HStack {
                        Image(systemName: trait.symbol)
                            .font(.system(size: 16))
                        Text(trait.title)
                            .font(.callout)
                    }
                    .foregroundColor(.primary)
                }
                .frame(height: 42)
                HStack {
                    ForEach(Level.allCases, id: \.self) { level in
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.accentColor.opacity(0.2))
                            VStack(spacing: 0) {
                                Image(systemName: level.symbol)
                                    .font(.system(size: 13).weight(.medium))
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(.primary)
                                Text(level.title(for: trait))
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(width: 64, height: 56)
                    }
                }
                .foregroundColor(.primary)
            }
            .padding(.vertical, 5)
        }
    }
}
