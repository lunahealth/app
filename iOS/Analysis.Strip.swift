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
                    .shadow(color: .black.opacity(scheme == .dark ? 0.3 : 0.08), radius: 3, y: -4)
                HStack(spacing: 0) {
                    ForEach(traits, id: \.self) { item in
                        Button {
                            trait = item
                        } label: {
                            ZStack {
                                if item == trait {
                                    Rectangle()
                                        .stroke(item.color, style: .init(lineWidth: 2))
                                    item.color.opacity(0.6).padding(1)
                                }
                                
                                Image(systemName: item.symbol)
                                    .font(.system(size: item == trait ? 18 : 15).weight(.medium))
                                    .foregroundColor(item == trait ? .white : item.color)
                            }
                            .contentShape(Rectangle())
                            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                        }
                        .animation(.easeInOut(duration: 0.3), value: trait)
                    }
                }
                .frame(height: 55)
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
