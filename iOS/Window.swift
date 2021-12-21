import SwiftUI

struct Window: View {
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
            
            Circle()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
