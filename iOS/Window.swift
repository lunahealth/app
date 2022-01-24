import SwiftUI
import Selene

struct Window: View {
    @State private var location = false
    @State private var froob = false
    @State private var settings = false
    @State private var calendar = false
    @State private var analysis = false
    @State private var track = false
    
    var body: some View {
        Home()
            .safeAreaInset(edge: .bottom, spacing: 0) {
                HStack(spacing: 0) {
                    Option(active: $settings,
                           title: "Settings",
                           symbol: "gear")
                        .padding(.leading)
                        .sheet(isPresented: $settings, content: Settings.init)
                    
                    Option(active: $calendar,
                           title: "Calendar",
                           symbol: "calendar")
                    Option(active: $analysis,
                           title: "Analysis",
                           symbol: "chart.line.uptrend.xyaxis")
                    Spacer()
                    Button {
                        track = true
                    } label: {
                        ZStack {
                            Image("Track")
                            Text("Track")
                                .font(.system(size: 12).weight(.medium))
                                .foregroundColor(.black)
                        }
                        .fixedSize()
                        .contentShape(Rectangle())
                    }
                    .padding(.trailing)
                    .sheet(isPresented: $track) {
                        Sheet(rootView: Track())
                            .equatable()
                            .edgesIgnoringSafeArea(.all)
                    }
                }
            }
            .sheet(isPresented: $location) {
                Settings.Location()
                    .equatable()
            }
            .sheet(isPresented: $froob, content: Froob.init)
            .task {
                cloud.ready.notify(queue: .main) {
                    cloud.pull.send()
                }
                
                switch Defaults.action {
                case .rate:
                    UIApplication.shared.review()
                case .froob:
                    froob = true
                case .none:
                    break
                }
                
                if !Defaults.hasLocated {
                    location = true
                    Defaults.hasLocated = true
                }
                
                _ = await UNUserNotificationCenter.request()
            }
    }
}
