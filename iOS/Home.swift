import SwiftUI
import Selene

struct Home: View {
    weak var observatory: Observatory!
    @State private var date = Date.now
    @State private var moon: Moon?
    @State private var wheel: Wheel?
    @State private var calendar = false
    private let haptics = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack {
            Stars()
                .equatable()
            
            if let moon = moon {
                Group {
                    Control(date: $date, wheel: $wheel, moon: moon)
                    if let wheel = wheel {
                        Render(moon: moon, wheel: wheel, current: wheel.origin)
                            .allowsHitTesting(false)
                    }
                }
                .frame(maxWidth: 450)

                Button {
                    calendar = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.tertiary)
                        Image(systemName: "calendar")
                            .font(.system(size: 24).weight(.light))
                            .foregroundColor(.primary)
                            .padding(8)
                    }
                    .fixedSize()
                    .contentShape(Rectangle())
                }
                .sheet(isPresented: $calendar) {
                    Cal(observatory: observatory)
                }
                
                Info(date: $date, moon: moon)
            }
        }
        .background(Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill))
        .edgesIgnoringSafeArea(.all)
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
