import CoreLocation
import Selene

final class Locator: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var coordinate: CLLocationCoordinate2D?
    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        coordinate = didUpdateLocations
            .first
            .map(\.coordinate)
    }
    
    func locationManager(_: CLLocationManager, didFailWithError: Error) {
        coordinate = .init(latitude: Defaults.coordinates.latitude, longitude: Defaults.coordinates.longitude)
    }
    
    #if os(iOS)
    func locationManager(_: CLLocationManager, didFinishDeferredUpdatesWithError: Error?) {
        coordinate = .init(latitude: Defaults.coordinates.latitude, longitude: Defaults.coordinates.longitude)
    }
    #endif
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
