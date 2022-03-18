import SwiftUI
import Selene

private let fontSize = 16.0

extension Track {
    struct Item: View {
        @Binding var journal: Journal?
        let trait: Trait
        
        var body: some View {
            NavigationLink(destination: Levels(journal: $journal, trait: trait)) {
                VStack(spacing: 4) {
                    ZStack {
                        if let level = journal?.traits[trait] {
                            Capsule()
                                .stroke(trait.color, style: .init(lineWidth: 2))
                                .frame(width: 100, height: 47)
                            Capsule()
                                .fill(trait.color.opacity(0.4))
                                .frame(width: 98, height: 45)
                            HStack(spacing: 0) {
                                Image(systemName: trait.symbol)
                                    .font(.system(size: fontSize).weight(.medium))
                                    .frame(width: 39)
                                Image(systemName: level.symbol)
                                    .font(.system(size: fontSize).weight(.medium))
                                    .frame(width: 39)
                            }
                            .padding(.horizontal, 10)
                        } else {
                            Circle()
                                .stroke(trait.color, style: .init(lineWidth: 2))
                                .frame(width: 47, height: 47)
                            Circle()
                                .fill(trait.color.opacity(0.4))
                                .frame(width: 45, height: 45)
                            Image(systemName: trait.symbol)
                                .font(.system(size: fontSize).weight(.medium))
                                .foregroundColor(.white)
                        }
                    }
                    Text(trait.title)
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(journal?.traits[trait] == nil ? .secondary : .primary)
                }
                .frame(width: 120)
            }
            .buttonStyle(.plain)
            .padding(.vertical)
        }
    }
}
