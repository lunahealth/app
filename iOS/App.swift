import SwiftUI

@main struct App: SwiftUI.App {
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    @State private var a = ""
    
    var body: some Scene {
        WindowGroup {
            Window()
                .background(Image("Background")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude))
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
