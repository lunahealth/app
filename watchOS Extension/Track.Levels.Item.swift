import SwiftUI
import Selene

extension Track.Levels {
    struct Item: View {
        let trait: Trait
        let level: Level
        let selected: Bool
        
        var body: some View {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .stroke(selected ? trait.color : .white, style: .init(lineWidth: 2))
                        .frame(width: 41, height: 41)
                    Circle()
                        .fill(selected ? trait.color.opacity(0.4) : .init(white: 1, opacity: 0.4))
                        .frame(width: 39, height: 39)
                    Image(systemName: level.symbol)
                        .font(.system(size: 16).weight(.medium))
                        .foregroundColor(.white)
                }
                Text(level.title(for: trait))
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(selected ? .primary : .secondary)
                    .padding(.top, 3)
            }
        }
    }
}
