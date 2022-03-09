import SwiftUI
import Selene

extension Analysis {
    struct Strip: View {
        @Binding var trait: Trait?
        let traits: [Trait]
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            border
            ZStack {
                Color(.secondarySystemBackground)
                    .shadow(color: .black.opacity(scheme == .dark ? 1 : 0.15), radius: 3, y: -4)
                HStack(spacing: 0) {
                    ForEach(traits, id: \.self) { item in
                        Button {
                            trait = item
                        } label: {
                            Image(systemName: item.symbol)
                                .font(.system(size: 13))
                                .foregroundColor(item == trait ? .white : .secondary)
                                .contentShape(Rectangle())
                                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                        }
                        .background(item == trait ? Color.accentColor : .clear)
                    }
                }
                .frame(height: 50)
            }
            border
        }
        
        private var border: some View {
            Rectangle()
                .fill(Color(white: 0, opacity: scheme == .dark ? 0.3 : 0.1))
                .frame(height: 1)
        }
    }
}
