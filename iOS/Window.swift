import SwiftUI
import Selene

struct Window: View {
    @StateObject private var status = Status()
    private let observatory = Observatory(coords: .init(coordinate: .init(latitude: 52.498252, longitude: 13.423622)))
    
    var body: some View {
        TabView {
            Home(observatory: observatory)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            Rectangle()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }

            Circle()
                .tabItem {
                    Label("Analysis", systemImage: "chart.bar")
                }

            Settings(status: status)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .sheet(item: $status.modal) {
            switch $0 {
            case .froob:
                Froob()
            case .onboard:
                Settings.Preferences()
            }
        }
        .task {
            switch Defaults.action {
            case .rate:
                UIApplication.shared.review()
            case .froob:
                status.modal = .froob
            case .none:
                break
            }
        }
    }
}
