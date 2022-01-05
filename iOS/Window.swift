import SwiftUI
import Selene

struct Window: View {
    @State private var location = false
    @State private var froob = false
    
    var body: some View {
        TabView {
            Home()
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
        .sheet(isPresented: $location) {
            Settings.Location()
                .equatable()
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
            
            if !Defaults.hasLocated {
                location = true
                Defaults.hasLocated = true
            }
        }
    }
}
