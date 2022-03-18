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
                        .fill(Color.white)
                        .frame(width: 42, height: 42)
                    if selected {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 38, height: 38)
                    }
                    Image(systemName: level.symbol)
                        .font(.system(size: 16).weight(.medium))
                        .foregroundColor(selected ? .white : .black)
                }
                Text(level.title(for: trait))
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(selected ? .primary : .secondary)
                    .padding(.top, 3)
            }
        }
    }
}
