import SwiftUI
import Selene

struct Window: View {
    @State private var observatory = Observatory()
    
    var body: some View {
        TabView {
            Home(observatory: $observatory)
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
