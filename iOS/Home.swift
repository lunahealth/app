import SwiftUI
import Selene

struct Home: View {
    @State private var date = Date.now
    @State private var moon: Moon?
    @State private var wheel: Wheel?
    @Environment(\.verticalSizeClass) private var vertical
    private let observatory = Observatory()
    private let haptics = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        VStack {
            if let moon = moon {
                if vertical == .compact {
                    Compact(date: $date,
                            moon: moon,
                            main: .init(date: $date,
                                        wheel: $wheel,
                                        observatory: observatory,
                                        moon: moon))
                } else {
                    Standard(date: $date,
                             moon: moon,
                             main: .init(date: $date,
                                         wheel: $wheel,
                                         observatory: observatory,
                                         moon: moon))
                }
            }
        }
        .background(Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all))
        .onReceive(cloud) {
            observatory.update(to: $0.coords)
            moon = observatory.moon(for: date)
        }
        .onChange(of: date) {
            moon = observatory.moon(for: $0)
            haptics.impactOccurred()
        }
        .onAppear {
            moon = observatory.moon(for: date)
            haptics.prepare()
        }
    }
}
