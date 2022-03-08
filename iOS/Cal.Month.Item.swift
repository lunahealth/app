import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Item: View {
        let day: Days<Journal>.Item
        let traits: [Trait]
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            VStack(spacing: 0) {
                ForEach(traits, id: \.self) { trait in
                    HStack(spacing: 0) {
                        if let level = day.content.traits[trait] {
                            Text(level.title(for: trait))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .frame(width: 120, alignment: .trailing)
                            Image(systemName: level.symbol)
                                .font(.system(size: 12).weight(.light))
                                .frame(width: 30)
                        } else {
                            Spacer()
                        }
                        Image(systemName: trait.symbol)
                            .font(.system(size: 12))
                            .foregroundStyle(day.content.traits[trait] == nil ? .tertiary : .primary)
                            .frame(width: 30)
                            .offset(x: -4)
                        Text(trait.title)
                            .font(.caption)
                            .foregroundStyle(day.content.traits[trait] == nil ? .tertiary : .secondary)
                            .frame(width: 120, alignment: .leading)
                    }
                    .frame(height: 34)
                }
            }
            .frame(width: 300)
        }
    }
}
