import SwiftUI
import Selene

struct Home: View {
    @State private var observatory = Observatory()
    @State private var moon: Moon?
    
    var body: some View {
        ZStack {
            if let moon = moon {
                Canvas { context, size in
                    context.draw(moon: moon,
                                 render: .regular,
                                 center: .init(x: size.width / 3, y: size.height / 3))
                }
                
                VStack(alignment: .trailing, spacing: 0) {
                    Spacer()
                    Text(moon.fraction, format: .number)
                        .font(.system(size: 40).weight(.light))
                    + Text("%")
                        .font(.caption.weight(.medium))
                    Text(moon.phase.name)
                        .font(.footnote.weight(.medium))
                }
                .padding(.trailing)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onReceive(cloud) {
            observatory.update(to: $0.coords)
            moon = observatory.moon(for: .now)
        }
        .onAppear {
            moon = observatory.moon(for: .now)
        }
    }
}
