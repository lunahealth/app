import SwiftUI
import CoreLocationUI
import Selene

struct Display: View {
    @StateObject private var locator = Locator()
    @State private var moon: Moon?
    @State private var slider = Float(0)
    @State private var test = Date.now
    @State private var location: Coords?
    private let date = Date.now
    private let observatory = Observatory()

    var body: some View {
        VStack {
            Text(test, format: .dateTime)
                .padding(.bottom)
            
            if let moon = moon {
                Text("\(moon.fraction)\n\(moon.angle)\n\(moon.azimuth)\n\(moon.altitude)")
                
                Text("\(moon.azimuth * 180 / .pi)")
            }
            Slider(value: $slider, in: -48 ... 48)
                .padding(.horizontal)
            LocationButton(.currentLocation) {
                locator.manager.requestLocation()
            }
            .foregroundColor(.white)
            .symbolVariant(.fill)
            .clipShape(Capsule())
            .font(.callout)
        }
        .onChange(of: slider) {
            test = Calendar.current.date(byAdding: .hour, value: .init($0), to: date)!
            update()
        }
        .onChange(of: locator.location) {
            location = $0
            update()
        }
    }
    
    private func update() {
        guard let location = location else { return }
        Task {
            moon = await observatory.moon(input: .init(date: test, coords: location))
        }
    }
}
