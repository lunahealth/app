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
                        .font(.callout.weight(.light).monospacedDigit())
                        .frame(width: 140, alignment: .trailing)
                    
                    ZStack {
                        Circle()
                            .fill(Color(.tertiarySystemBackground))
                            .frame(width: 34, height: 34)
                            .modifier(Shadowed())
                        Image(systemName: item.level.symbol)
                            .font(.system(size: 13).weight(.light))
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
