import SwiftUI
import Selene

struct Home: View {
    weak var observatory: Observatory!
    @State private var date = Date.now
    @State private var moon: Moon?
    @State private var wheel: Wheel?
    private let haptics = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack {
            Stars()
                .equatable()
            
            if let moon = moon {
                Group {
                    Control(date: $date, wheel: $wheel, moon: moon)
                    if let wheel = wheel {
                        Render(moon: moon, wheel: wheel, current: wheel.origin)
                            .allowsHitTesting(false)
                    }
                    
                    Info(date: $date, moon: moon)
                        .padding(.horizontal, 90)
                        .frame(height: 150)
                }
                .frame(maxWidth: 550)
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            if let moon = moon {
                Detail(observatory: observatory, moon: moon, date: date)
            }
        }
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
