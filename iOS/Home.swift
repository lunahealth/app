import SwiftUI
import Selene

struct Home: View {
    @State private var date = Date.now
    @State private var moon: Moon?
    @State private var wheel: Wheel?
    private let observatory = Observatory()
    private let haptics = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        VStack {
            if let moon = moon {
                Spacer()
                Info(date: $date, moon: moon)
                Main(date: $date,
                     wheel: $wheel,
                     observatory: observatory,
                     moon: moon)
                Today(date: $date)
                    .padding(.bottom, 40)
            }
        }
        .background(Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all))
        .onReceive(cloud) {
            observatory.update(to: $0.coords)
            moon = observatory.moon(for: date)
        }
        .onChange(of: date) {
            moon = observatory.moon(for: $0)
            haptics.impactOccurred()
        }
        .onAppear {
            moon = observatory.moon(for: date)
            haptics.prepare()
        }
    }
}
