import SwiftUI
import WidgetKit
import Selene

private let maxWidth = 550.0

struct Home: View {
    let observatory: Observatory
    @Binding var date: Date
    @Binding var track: Bool
    @State private var moon: Moon?
    @State private var navigator: Navigator?
    @State private var calendar = false
    private let haptics = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack {
            Stars()
                .equatable()
            
            if let moon = moon {
                Control(date: $date,
                        navigator: $navigator,
                        moon: moon,
                        track: track,
                        maxWidth: maxWidth)
                
                if let wheel = navigator {
                    Render(current: wheel.origin,
                           moon: moon,
                           navigator: wheel)
                        .allowsHitTesting(false)
                }
                
                Button {
                    date = .now
                    calendar = true
                } label: {
                    Image(systemName: "calendar.circle.fill")
                        .font(.system(size: 44).weight(.ultraLight))
                        .symbolRenderingMode(.hierarchical)
                        .tint(.white)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                }
                .opacity(track ? 0 : 1)
                .animation(.easeInOut(duration: 0.3), value: track)
                .sheet(isPresented: $calendar) {
                    Cal(observatory: observatory)
                        .equatable()
                }
                
                Track(track: track)
                    .opacity(track ? 1 : 0)
                    .animation(.easeInOut(duration: 0.4), value: track)
                
                VStack {
                    Header(date: $date, track: $track, observatory: observatory, moon: moon)
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onReceive(cloud) {
            observatory.update(to: $0.coords)
            moon = observatory.moon(for: date)
            
            if Defaults.coordinates != $0.coords {
                Defaults.coordinates = $0.coords
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        .onChange(of: date) {
            moon = observatory.moon(for: $0)
            
            if Defaults.enableHaptics {
                haptics.impactOccurred()
            }
        }
        .onAppear {
            moon = observatory.moon(for: date)
            
            if Defaults.enableHaptics {
                haptics.prepare()
            }
        }
    }
}
