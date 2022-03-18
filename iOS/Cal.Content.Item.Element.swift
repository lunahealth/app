import SwiftUI
import Selene
import Dater

extension Cal.Content.Item {
    struct Element: View {
        let day: Days<Journal>.Item
        let trait: Trait
        
        var body: some View {
            ZStack {
                if day.content.traits[trait] == nil {
                    Circle()
                        .fill(Color.primary.opacity(0.2))
                    Circle()
                        .fill(Color(.systemFill))
                        .padding(1)
                } else {
                    Capsule()
                        .stroke(trait.color, style: .init(lineWidth: 2))
                    Capsule()
                        .fill(trait.color.opacity(0.6))
                        .padding(1)
                }
                
                VStack(spacing: 0) {
                    if let level = day.content.traits[trait] {
                        Image(systemName: level.symbol)
                            .font(.system(size: 13).weight(.medium))
                            .foregroundColor(.white)
                            .frame(height: 30)
                    }
                    Image(systemName: trait.symbol)
                        .font(.system(size: 13).weight(.medium))
                        .foregroundColor(day.content.traits[trait] == nil ? .init(white: 1, opacity: 0.7) : .white)
                        .frame(height: 30)
                }
                .padding(.vertical, 10)
            }
            .frame(width: 40)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
