import SwiftUI
import CoreLocationUI
import Selene

struct Display: View {
    @StateObject private var locator = Locator()
    @State private var moon: Moon?
    @State private var slider = Float(0)
    @State private var test = Date.now
    @State private var segmented = 0
    private let location = Coords(coordinate: .init(latitude: 52.498252, longitude: 13.423622))
    private let date = Date.now
    private let observatory = Observatory()

    var body: some View {
        VStack {
            Picker("Display", selection: $segmented) {
                Text("Azimuth")
                    .tag(0)
                Text("Altitude")
                    .tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            if let moon = moon {
                switch segmented {
                case 0:
                    Azimuth(moon: moon)
                default:
                    Altitude(moon: moon)
                }
            }
            
            Text(test, format: .dateTime)
            Slider(value: $slider, in: -72 ... 72)
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
            
            print(moon!.altitude / .pi * 150)
        }
    }
}
