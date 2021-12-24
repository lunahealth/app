import SwiftUI
import Selene

struct Home: View {
    @Binding var observatory: Observatory
    @State private var date = Date.now
    @State private var moon: Moon?
    @State private var wheel: Wheel?
    private let location = Coords(coordinate: .init(latitude: 52.498252, longitude: 13.423622))
    @Environment(\.verticalSizeClass) private var vertical
    
    var body: some View {
        VStack {
            if let moon = moon {
                if vertical == .compact {
                    Compact(date: $date, wheel: $wheel, moon: moon)
                } else {
                    Standard(date: $date, wheel: $wheel, moon: moon)
                }
            }
        }
        .onChange(of: date) {
            update(date: $0)
        }
        .onAppear {
            update(date: date)
        }
    }
    
    private func update(date: Date) {
        moon = observatory.moon(input: .init(date: date, coords: location))
    }
}
