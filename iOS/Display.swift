import SwiftUI
import CoreLocationUI
import Selene

struct Display: View {
    @StateObject private var locator = Locator()

    var body: some View {
        VStack {
            if let location = locator.location {
                Text("Your location: \(location.latitude), \(location.longitude)")
            }

            LocationButton(.currentLocation) {
                locator.manager.requestLocation()
            }
            .foregroundColor(.white)
            .symbolVariant(.fill)
            .clipShape(Capsule())
            .font(.callout)
        }
    }
}
