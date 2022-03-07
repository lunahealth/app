import SwiftUI
import Selene

extension Analysis {
    struct Info: View {
        let trait: Trait
        let stats: Stats
        
        var body: some View {
            HStack {
                Text("Track count")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                Text(stats.count, format: .number)
                    .font(.callout.weight(.light).monospacedDigit())
                Spacer()
            }
            .frame(height: 48)
            .padding(.top)
            
            Rectangle()
                .fill(Color.primary.opacity(0.1))
                .frame(height: 1)
            
            HStack {
                Text("Most recent")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                Image(systemName: stats.recent.symbol)
                    .font(.system(size: 14).weight(.light))
                    .frame(width: 30, height: 50)
                Spacer()
            }
            .frame(height: 48)
            
            Rectangle()
                .fill(Color.primary.opacity(0.1))
                .frame(height: 1)
                .padding(.bottom)
            
            ForEach(stats.distribution, id: \.level) { item in
                HStack {
                    Text(item.percent, format: .percent.precision(.significantDigits(2)))
                        .font(.footnote.weight(.light).monospacedDigit())
                        .frame(width: 150, alignment: .trailing)
                    
                    ZStack {
                        Circle()
                            .fill(Color(.tertiarySystemBackground))
                            .frame(width: 28, height: 28)
                        Image(systemName: item.level.symbol)
                            .font(.system(size: 11).weight(.light))
                    }
                    .fixedSize()
                    
                    Text(item.level.title(for: trait))
                        .foregroundStyle(.secondary)
                        .font(.caption.weight(.light))
                        .frame(width: 150, alignment: .leading)
                }
                .padding(.vertical, 8)
            }
        }
    }
}
