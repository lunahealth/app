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
                ZStack {
                    HStack {
                        Option(active: $analysis,
                               title: "Analysis",
                               symbol: "chart.line.uptrend.xyaxis")
                            .padding(.leading)
                        Spacer()
                        Option(active: $settings,
                               title: "Settings",
                               symbol: "gear")
                            .sheet(isPresented: $settings, content: Settings.init)
                            .padding(.trailing)
                    }
                    
                    Button {
                        track = true
                    } label: {
                        ZStack {
                            Image("Track")
                            Text("Track")
                                .font(.system(size: 13).weight(.medium))
                                .foregroundColor(.black)
                        }
                        .fixedSize()
                        .contentShape(Rectangle())
                    }
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
