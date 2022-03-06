import SwiftUI
import Selene

struct Window: View {
    @State private var location = false
    @State private var froob = false
    @State private var settings = false
    @State private var analysis = false
    @State private var track = false
    @State private var date = Date.now
    @State private var observatory = Observatory()
    
    var body: some View {
        Home(observatory: observatory, date: $date)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                HStack {
                    Option(active: $settings,
                           title: "Settings",
                           symbol: "gear")
                        .padding(.leading)
                        .sheet(isPresented: $settings, content: Settings.init)
                    
                    Spacer()
                    
                    Button {
                        date = .now
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
                        SheetMinimal(rootView: Track())
                            .equatable()
                            .edgesIgnoringSafeArea(.all)
                    }
                    
                    Spacer()
                    
                    Option(active: $analysis,
                           title: "Analysis",
                           symbol: "chart.line.uptrend.xyaxis")
                        .padding(.trailing)
                        .sheet(isPresented: $analysis) {
                            Analysis(observatory: observatory)
                                .equatable()
                        }
                }
                .padding(.bottom, 10)
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
