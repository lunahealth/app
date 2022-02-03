import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Item: View {
        let day: Days<Journal>.Item
        let traits: [Trait]
        
        var body: some View {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.accentColor.opacity(0.2))
                    VStack(spacing: 0) {
                        ForEach(traits, id: \.self) { trait in
                            if trait != traits.first {
                                Rectangle()
                                    .fill(.quaternary)
                                    .frame(height: 1)
                                    .padding(.horizontal)
                            }
                            HStack {
                                Image(systemName: trait.symbol)
                                    .font(.system(size: 14))
                                    .foregroundColor(day.content.traits[trait] == nil ? .secondary : trait.color)
                                    .frame(width: 34)
                                Text(trait.title)
                                    .font(.callout)
                                    .foregroundColor(day.content.traits[trait] == nil ? .secondary : .primary)
                                Spacer()
                                if let symbol = day.content.traits[trait]?.symbol {
                                    ZStack {
                                        Circle()
                                            .fill(Color.accentColor.opacity(0.2))
                                            .frame(width: 28, height: 28)
                                        Image(systemName: symbol)
                                            .font(.system(size: 11).weight(.medium))
                                    }
                                } else {
                                    
                                }
                            }
                            .frame(height: 42)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .frame(width: 230)
                .fixedSize()
                Spacer()
            }
        }
    }
}
