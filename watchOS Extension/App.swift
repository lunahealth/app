import SwiftUI
 
@main struct App: SwiftUI.App {
    @StateObject private var locator = Locator()
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Main()
                .task {
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                    }

                    WKExtension.shared().registerForRemoteNotifications()
                    location()
                }
        }
        .onChange(of: locator.coordinate) {
            if let coordinate = $0 {
                Task {
                    await cloud.coords(latitude: coordinate.latitude, longitude: coordinate.longitude)
                }
            }
        }
        .onChange(of: phase) {
            switch $0 {
            case .active:
                cloud.pull.send()
                location()
            default:
                break
            }
        }
    }
    
    private func location() {
        if CLLocationManager().authorizationStatus == .notDetermined {
            locator.manager.requestWhenInUseAuthorization()
        } else {
            locator.manager.requestLocation()
        }
    }
}
