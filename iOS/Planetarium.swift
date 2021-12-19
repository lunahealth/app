import SwiftUI
import Selene

struct Planetarium: View {
    let moon: Moon
    
    var body: some View {
        ZStack {
            Render(moon: moon)
            
            VStack {
                Text(verbatim: "\(moon.phase)")
                Text(moon.fraction, format: .percent)
                Spacer()
            }
            .padding(.top, 350)
        }
    }
}
