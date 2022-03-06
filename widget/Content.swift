import SwiftUI

private let pad = 20.0

struct Content: View {
    let entry: Entry
    
    var body: some View {
        ZStack {
            Canvas { context, size in
                context.draw(moon: entry.moon,
                             render: .regular,
                             center: .init(x: Render.regular.radius + pad, y: Render.regular.radius + pad))
            }
            
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                Text(entry.moon.fraction, format: .number)
                    .font(.title.weight(.medium).monospacedDigit())
                + Text("%")
                    .font(.caption)
                Text(entry.moon.phase.name)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 16)
            }
            .foregroundColor(.white)
            .padding(.trailing, pad)
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
        }
        .background(Image("Background"))
    }
}
