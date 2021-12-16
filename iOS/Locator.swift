import CoreLocation

final class Locator: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var location: CLLocationCoordinate2D?
    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]) {
        location = didUpdateLocations.first?.coordinate
    }
    
    func locationManager(_: CLLocationManager, didFailWithError: Error) {
        
    }
}
