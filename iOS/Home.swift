import SwiftUI

struct Home: View {
    @State private var date = Date.now
    
    var body: some View {
        ZStack {
            Info(date: $date)
        }
    }
}
