import SwiftUI
import Selene

extension Analysis {
    struct Info: View {
        let trait: Trait
        let stats: [Stats]
        
        var body: some View {
            ForEach(stats, id: \.level) { item in
                HStack {
                    Text(item.percent, format: .percent.precision(.significantDigits(2)))
                        .font(.body.monospacedDigit())
                        .frame(width: 140, alignment: .trailing)
                    
                    ZStack {
                        Circle()
                            .stroke(trait.color, style: .init(lineWidth: 2))
                            .frame(width: 40, height: 40)
                        Circle()
                            .fill(trait.color.opacity(0.6))
                            .frame(width: 38, height: 38)
                        Image(systemName: item.level.symbol)
                            .font(.system(size: 16).weight(.bold))
                            .foregroundColor(.white)
                    }
                    .fixedSize()
                    .padding(.horizontal, 5)
                    
                    Text(item.level.title(for: trait))
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        .frame(width: 140, alignment: .leading)
                }
                .frame(height: 60)
            }
        }
    }
}
