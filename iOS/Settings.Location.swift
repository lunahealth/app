import SwiftUI
import MapKit
import CoreLocationUI

extension Settings {
    struct Location: View, Equatable {
        @StateObject private var locator = Locator()
        @State private var region = MKCoordinateRegion()
        @State private var loaded = false
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack {
                if loaded {
                    Map(coordinateRegion: $region,
                        showsUserLocation: true,
                        userTrackingMode: .constant(.none))
                        .edgesIgnoringSafeArea(.all)
                }
                Text(.init(Copy.location))
                    .font(.footnote)
                    .padding()
                
                LocationButton(.currentLocation) {
                    locator.manager.requestLocation()
                }
                .foregroundColor(.white)
                .symbolVariant(.fill)
                .clipShape(Capsule())
                .font(.callout)
                
                Button {
                    Task {
                        await save(latitude: region.center.latitude, longitude: region.center.longitude)
                    }
                } label: {
                    Text("Use map position")
                        .font(.footnote)
                        .frame(height: 45)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)
                .tint(.secondary)
                .padding(.bottom)
            }
            .onChange(of: locator.coordinate) {
                if let coordinate = $0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        Task {
                            await save(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        }
                    }
                }
            }
            .task {
                let model = await cloud.model
                region = .init(center: .init(latitude: model.coords.latitude,
                                             longitude: model.coords.longitude),
                               span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
                
                loaded = true
            }
        }
        
        private func save(latitude: Double, longitude: Double) async {
            await cloud.coords(latitude: latitude, longitude: longitude)
            dismiss()
        }
        
        static func == (lhs: Settings.Location, rhs: Settings.Location) -> Bool {
            true
        }
    }
}
