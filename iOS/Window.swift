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
        Home(observatory: observatory, date: $date, track: $track)
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
                    .frame(height: track ? 0 : nil)
                    .opacity(track ? 0 : 1)
                    .padding(.bottom, track ? 0 : 10)
                    .animation(.easeInOut(duration: 0.3), value: track)
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
