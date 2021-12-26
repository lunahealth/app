import SwiftUI
import Selene

struct Window: View {
    let observatory = Observatory(coords: .init(coordinate: .init(latitude: 52.498252, longitude: 13.423622)))
    
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
            
            Circle()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
