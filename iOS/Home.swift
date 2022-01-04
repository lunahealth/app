import SwiftUI
import Selene

struct Home: View {
    let observatory: Observatory
    @State private var date = Date.now
    @State private var moon: Moon?
    @State private var wheel: Wheel?
    @Environment(\.verticalSizeClass) private var vertical
    
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
        .onChange(of: date) {
            moon = observatory.moon(for: $0)
        }
        .onAppear {
            moon = observatory.moon(for: date)
        }
    }
}
