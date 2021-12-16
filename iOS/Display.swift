import SwiftUI
import CoreLocationUI
import Selene

struct Display: View {
    @StateObject private var locator = Locator()
    private let observatory = Observatory()

    var body: some View {
        VStack {
            LocationButton(.currentLocation) {
                locator.manager.requestLocation()
            }
            .foregroundColor(.white)
            .symbolVariant(.fill)
            .clipShape(Capsule())
            .font(.callout)
        }
        .onChange(of: locator.location) {
            guard let location = $0 else { return }
            Task {
                let moon = await observatory.moon(input: .init(date: .now, coords: location))
                print(moon)
            }
        }
    }
}
