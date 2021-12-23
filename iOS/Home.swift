import SwiftUI
import Selene

struct Home: View {
    @Binding var observatory: Observatory
    @State private var date = Date.now
    @State private var moon = Moon.new
    @State private var wheel = Wheel(date: .now, moon: .new, correction: .pi_2)
    private let location = Coords(coordinate: .init(latitude: 52.498252, longitude: 13.423622))
    
    var body: some View {
        VStack {
            Info(date: $date, moon: moon)
            ZStack {
                Render(date: date, moon: moon, wheel: wheel)
                Control(date: $date, wheel: wheel)
            }
            .padding()
        }
        .onAppear(perform: update)
        .onChange(of: date) { _ in
            update()
        }
    }
    
    private func update() {
        moon = observatory.moon(input: .init(date: date, coords: location))
        wheel = .init(date: date, moon: moon, correction: .pi_2)
    }
}
