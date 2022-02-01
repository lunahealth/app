import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Item: View {
        let day: Days<Journal>.Item
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.accentColor.opacity(0.1))
                if day.content.date > .now {
                    Text("Coming soon...")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                } else if day.content.traits.isEmpty {
                    Text("No traits tracked this day.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                } else {
                    VStack {
                        ForEach(day.content.traits.keys.sorted(), id: \.self) { trait in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.accentColor.opacity(0.2))
                                HStack(spacing: 0) {
                                    Image(systemName: trait.symbol)
                                        .font(.system(size: 20))
                                        .foregroundColor(trait.color)
                                        .frame(width: 80)
                                    Text(trait.title)
                                        .font(.callout)
                                    Spacer()
                                    Image(systemName: day.content.traits[trait]!.symbol)
                                        .font(.system(size: 16))
                                        .frame(width: 70)
                                }
                                .padding(.vertical)
                            }
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}
