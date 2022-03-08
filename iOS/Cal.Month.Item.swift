import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Item: View {
        let day: Days<Journal>.Item
        let traits: [Trait]
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.tertiarySystemBackground))
                        .shadow(color: .black.opacity(scheme == .dark ? 1 : 0.15), radius: 3)
                    VStack(spacing: 0) {
                        ForEach(traits, id: \.self) { trait in
                            if trait != traits.first {
                                Rectangle()
                                    .fill(.quaternary)
                                    .frame(height: 1)
                                    .padding(.horizontal)
                            }
                            
                            if let symbol = day.content.traits[trait]?.symbol {
                                HStack(spacing: 0) {
                                    Image(systemName: trait.symbol)
                                        .font(.system(size: 14))
                                        .foregroundStyle(trait.color)
                                        .frame(width: 38)
                                    Text(trait.title)
                                        .font(.callout)
                                        .foregroundStyle(.primary)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Circle()
                                            .fill(Color.accentColor.opacity(0.2))
                                            .frame(width: 28, height: 28)
                                        Image(systemName: symbol)
                                            .font(.system(size: 11).weight(.medium))
                                    }
                                }
                                .frame(height: 42)
                            } else {
                                HStack(spacing: 0) {
                                    Image(systemName: trait.symbol)
                                        .font(.system(size: 14))
                                        .frame(width: 38)
                                    Text(trait.title)
                                        .font(.callout)
                                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                                    Spacer()
                                }
                                .foregroundStyle(.tertiary)
                                .frame(height: 42)
                            }
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.trailing)
                    .padding(.vertical, 8)
                }
                .frame(width: 200)
                .fixedSize()
                Spacer()
            }
        }
    }
}
