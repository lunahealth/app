import SwiftUI
import UserNotifications

@main struct App: SwiftUI.App {
    @StateObject private var status = Status()
    @Environment(\.scenePhase) private var phase
    @WKExtensionDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            Main(status: status)
                .task {
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                    }
                    
                    await status.request()
                    _ = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
                    WKExtension.shared().registerForRemoteNotifications()
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
