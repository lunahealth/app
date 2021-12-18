import SwiftUI
import CoreLocationUI
import Selene

struct Display: View {
    @StateObject private var locator = Locator()
    @State private var moon: Moon?
    @State private var slider = Float(0)
    @State private var test = Date.now
    private let location = Coords(coordinate: .init(latitude: 52.498252, longitude: 13.423622))
    private let date = Date.now
    private let observatory = Observatory()

    var body: some View {
        VStack {
            if let moon = moon {
                Azimuth(moon: moon)
            }
            Text(test, format: .dateTime)
            Slider(value: $slider, in: -48 ... 48)
                .padding(.horizontal)
        }
        .onChange(of: slider) {
            test = Calendar.current.date(byAdding: .hour, value: .init($0), to: date)!
            update()
        }
        .onAppear {
            update()
        }
    }
    
    private func update() {
        Task {
            moon = await observatory.moon(input: .init(date: test, coords: location))
        }
    }
}
