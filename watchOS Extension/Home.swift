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
                                 center: .init(x: size.width / 2, y: size.height / 2))
                }
            }
        }
        .onReceive(cloud) {
            observatory.update(to: $0.coords)
            moon = observatory.moon(for: .now)
        }
        .onAppear {
            moon = observatory.moon(for: .now)
        }
    }
}
