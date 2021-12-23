import SwiftUI
import Selene

struct Home: View {
    @Binding var observatory: Observatory
    @State private var date = Date.now
    @State private var moon: Moon?
    @State private var wheel: Wheel?
    private let location = Coords(coordinate: .init(latitude: 52.498252, longitude: 13.423622))
    
    var body: some View {
        VStack {
            if let moon = moon {
                Info(date: $date, moon: moon)
                ZStack {
                    if let wheel = wheel {
                        Render(moon: moon, point: wheel.origin, current: wheel.origin)
                    }
                    Control(date: $date, wheel: $wheel, moon: moon)
                }
                .padding()
            }
        }
        .onAppear(perform: update)
        .onChange(of: date) { _ in
            update()
        }
    }
    
    private func update() {
        moon = observatory.moon(input: .init(date: date, coords: location))
    }
}
