import SwiftUI

private let radius = 34.0
private let pad = 20.0

struct Content: View {
    let entry: Entry
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
            Canvas { context, size in
                context.draw(moon: entry.moon,
                             image: .init("Moon"),
                             shadow: .init("ShadowAlphaless"),
                             radius: radius,
                             center: .init(x: radius + pad, y: radius + pad))
            }
            Group {
                Text(entry.moon.fraction, format: .number)
                    .font(.title.weight(.medium).monospacedDigit())
                + Text("%\n")
                    .foregroundColor(.secondary)
                    .font(.caption)
                + Text(entry.moon.phase.name)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            .multilineTextAlignment(.trailing)
            .padding([.trailing, .bottom], pad)
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottomTrailing)
        }
    }
}
