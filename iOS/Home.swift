import SwiftUI
import WidgetKit
import Selene

struct Home: View {
    let observatory: Observatory
    @Binding var date: Date
    let track: Bool
    @State private var moon: Moon?
    @State private var navigator: Navigator?
    private let haptics = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack {
            Stars()
                .equatable()
            
            if let moon = moon {
                Group {
                    Control(date: $date, navigator: $navigator, moon: moon, track: track)
                    
                    if let wheel = navigator {
                        Render(current: wheel.origin,
                               moon: moon,
                               navigator: wheel)
                            .allowsHitTesting(false)
                    }
                    
                    if !track {
                        Info(date: $date, moon: moon)
                            .padding(.horizontal, 90)
                            .frame(height: 150)
                    }
                }
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            if let moon = moon {
                Detail(observatory: observatory, moon: moon, date: date)
            }
        }
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
            haptics.impactOccurred()
        }
        .onAppear {
            moon = observatory.moon(for: date)
            haptics.prepare()
        }
    }
}
