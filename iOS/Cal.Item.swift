import SwiftUI
import Dater
import Selene

extension Cal {
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
                                .font(.footnote)
                                .foregroundStyle(.tertiary)
                                .frame(width: 120, alignment: .trailing)
                            Image(systemName: level.symbol)
                                .font(.system(size: 16).weight(.light))
                                .frame(width: 40)
                        } else {
                            Text("—")
                                .font(.footnote)
                                .foregroundStyle(.quaternary)
                                .frame(width: 120, alignment: .trailing)
                            Image(systemName: "questionmark")
                                .font(.system(size: 12).weight(.light))
                                .foregroundStyle(.tertiary)
                                .frame(width: 40)
                        }
                        Image(systemName: trait.symbol)
                            .font(.system(size: 14))
                            .foregroundStyle(day.content.traits[trait] == nil ? .tertiary : .primary)
                            .frame(width: 40)
                            .offset(x: -4)
                        Text(trait.title)
                            .font(.footnote)
                            .foregroundStyle(day.content.traits[trait] == nil ? .quaternary : .tertiary)
                            .frame(width: 120, alignment: .leading)
                    }
                    .frame(height: 38)
                }
                Spacer()
            }
            .frame(width: 320)
            .padding(.top, 10)
        }
    }
}
