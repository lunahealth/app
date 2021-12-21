import SwiftUI
import Selene

struct Home: View {
    weak var observatory: Observatory!
    @State private var date = Date.now
    @State private var moon = Moon.new
    private let location = Coords(coordinate: .init(latitude: 52.498252, longitude: 13.423622))
    
    var body: some View {
        ZStack {
            Map(moon: $moon)
            Info(date: $date, moon: $moon)
        }
        .onAppear(perform: update)
        .onChange(of: date) { _ in
            update()
        }
    }
    
    private func update() {
        Task {
            moon = await observatory.moon(input: .init(date: date, coords: location))
        }
    }
}
