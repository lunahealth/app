import SwiftUI
import Selene

extension AnalysisOld {
    struct Header: View {
        let trait: Trait
        
        var body: some View {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor.opacity(0.4))
                    Label(trait.title, systemImage: trait.symbol)
                }
                .frame(height: 46)
                HStack {
                    ForEach(Level.allCases, id: \.self) { level in
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.accentColor.opacity(0.1))
                            VStack(spacing: 0) {
                                Image(systemName: level.symbol)
                                    .font(.system(size: 13).weight(.medium))
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.primary)
                                Text(level.title(for: trait))
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(width: 64, height: 44)
                    }
                }
            }
            .foregroundColor(.primary)
            .padding(.vertical, 5)
        }
    }
}
