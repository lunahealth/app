import SwiftUI
import MapKit
import CoreLocationUI
import WidgetKit
import Selene

extension Settings {
    struct Location: View, Equatable {
        @StateObject private var locator = Locator()
        @State private var region = MKCoordinateRegion()
        @State private var loaded = false
        @Environment(\.dismiss) private var dismiss
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            VStack(spacing: 0) {
                if loaded {
                    Map(coordinateRegion: $region,
                        showsUserLocation: true,
                        userTrackingMode: .constant(.none))
                        .edgesIgnoringSafeArea(.all)
                }
                
                Rectangle()
                    .fill(Color(white: 0, opacity: scheme == .dark ? 1 : 0.4))
                    .frame(height: 1)
                
                Text(.init(Copy.location))
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 30)
                
                LocationButton(.currentLocation) {
                    locator.manager.requestLocation()
                }
                .foregroundColor(.white)
                .symbolVariant(.fill)
                .clipShape(Capsule())
                .font(.callout)
                .padding(.vertical, 30)
                
                Button {
                    save(coordinate: region.center)
                } label: {
                    Text("Location from Map")
                        .font(.callout)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .tint(.secondary)
                .padding(.bottom, 30)
            }
            .onChange(of: locator.coordinate) {
                if let coordinate = $0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        save(coordinate: coordinate)
                    }
                }
            }
            .task {
                region = .init(center: .init(latitude: Defaults.coordinates.latitude,
                                             longitude: Defaults.coordinates.longitude),
                               span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
                
                loaded = true
            }
        }
        
        private func save(coordinate: CLLocationCoordinate2D) {
            Defaults.coordinates = .init(coordinate: coordinate)
            WidgetCenter.shared.reloadAllTimelines()
            dismiss()
        }
        
        static func == (lhs: Settings.Location, rhs: Settings.Location) -> Bool {
            true
        }
    }
}
