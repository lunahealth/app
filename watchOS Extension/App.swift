import SwiftUI
import Selene
 
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
                    locator.manager.requestLocation()
                }
        }
        .onChange(of: locator.coordinate) {
            if let coordinate = $0 {
                Defaults.coordinates = .init(coordinate: coordinate)
            }
        }
        .onChange(of: phase) {
            switch $0 {
            case .active:
                cloud.pull.send()
            default:
                break
            }
        }
    }
}
