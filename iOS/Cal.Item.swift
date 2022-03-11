import SwiftUI
import Dater
import Selene

extension Cal {
    struct Item: View {
        let day: Days<Journal>.Item
        let traits: [Trait]
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            HStack(spacing: 12) {
                ForEach(traits, id: \.self) { trait in
                    ZStack {
                        Capsule()
                            .fill(Color(.secondarySystemBackground))
                            .modifier(Shadowed())
                        VStack(spacing: 0) {
                            if let level = day.content.traits[trait] {
                                Image(systemName: level.symbol)
                                    .font(.system(size: 13).weight(.medium))
                                    .frame(height: 30)
                            }
                            Image(systemName: trait.symbol)
                                .font(.system(size: 12))
                                .foregroundStyle(day.content.traits[trait] == nil ? .tertiary : .primary)
                                .frame(height: 30)
                        }
                        .padding(.vertical, 10)
                    }
                    .frame(width: 36)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
