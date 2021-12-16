import CoreLocation
import Selene

final class Locator: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var location: Coords?
    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        didUpdateLocations
            .first
            .map(\.coordinate)
            .map(Coords.init(coordinate:))
            .map {
                location = $0
            }
    }
    
    func locationManager(_: CLLocationManager, didFailWithError: Error) {
        
    }
}
