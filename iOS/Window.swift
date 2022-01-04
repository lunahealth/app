import SwiftUI
import Selene

struct Window: View {
    @State private var froob = false
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

            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .sheet(isPresented: $froob, content: Froob.init)
        .task {
            switch Defaults.action {
            case .rate:
                UIApplication.shared.review()
            case .froob:
                froob = true
            case .none:
                break
            }
        }
    }
}
