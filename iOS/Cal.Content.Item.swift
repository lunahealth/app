import SwiftUI
import Dater
import Selene

extension Cal.Content {
    struct Item: View {
        let day: Days<Journal>.Item
        let traits: [Trait]
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            HStack(spacing: 15) {
                ForEach(traits, id: \.self) { trait in
                    ZStack {
                        Capsule()
                            .fill(day.content.traits[trait] == nil ? .init(.secondarySystemBackground) : trait.color)
                            .modifier(Shadowed(level: .minimum))
                        VStack(spacing: 0) {
                            if let level = day.content.traits[trait] {
                                Image(systemName: level.symbol)
                                    .font(.system(size: 13).weight(.medium))
                                    .foregroundColor(.white)
                                    .frame(height: 30)
                            }
                            Image(systemName: trait.symbol)
                                .font(.system(size: 13).weight(.medium))
                                .foregroundStyle(day.content.traits[trait] == nil ? .tertiary : .primary)
                                .foregroundColor(day.content.traits[trait] == nil ? .primary : .white)
                                .frame(height: 30)
                        }
                        .padding(.vertical, 10)
                    }
                    .frame(width: 40)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
