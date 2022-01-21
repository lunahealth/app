import SwiftUI
import Selene

struct Home: View {
    @State private var date = Date.now
    @State private var moon: Moon?
    @State private var wheel: Wheel?
    private let observatory = Observatory()
    private let haptics = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack(alignment: .top) {
            if let moon = moon {
                VStack {
                    Group {
                        Text(moon.fraction, format: .number)
                            .font(.title.weight(.medium).monospacedDigit())
                        + Text("%  ")
                            .font(.caption)
                    }
                    .padding(.leading, 10)
                    Text(moon.phase.name)
                        .font(.footnote)
                }
                .frame(maxHeight: .greatestFiniteMagnitude)
                .allowsHitTesting(false)
                
                Group {
                    Control(date: $date, wheel: $wheel, moon: moon)
                    if let wheel = wheel {
                        Render(moon: moon, wheel: wheel, current: wheel.origin)
                            .allowsHitTesting(false)
                    }
                }
                .frame(maxWidth: 450)
                
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
