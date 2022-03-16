import SwiftUI

struct Main: View {
    @State private var loading = true
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            if loading {
                Image(systemName: "hourglass")
                    .font(.system(size: 40).weight(.ultraLight))
                    .foregroundColor(.accentColor)
                    .symbolRenderingMode(.hierarchical)
            } else {
                Home()
                Rectangle()
            }
        }
        .onAppear {
            cloud.ready.notify(queue: .main) {
                loading = false
            }
        }
    }
}
