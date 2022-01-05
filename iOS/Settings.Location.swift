import SwiftUI
import MapKit

extension Settings {
    struct Location: View {
        @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.522399, longitude: 13.413027), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @State private var tracking = MapUserTrackingMode.follow
        
        var body: some View {
            VStack {
                Map(coordinateRegion: $region,
                    showsUserLocation: true,
                    userTrackingMode: $tracking)
                    .frame(maxHeight: 300)
                    .edgesIgnoringSafeArea(.all)
                Text(.init(Copy.location))
                    .font(.footnote)
                    .padding()
                Spacer()
            }
        }
    }
}
