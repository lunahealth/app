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
    @State private var moon: Moon?
    private let haptics = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        Home(date: $date, track: $track, observatory: observatory, moon: moon)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                    HStack {
                        Option(active: $settings,
                               title: "Settings",
                               symbol: "gear")
                            .padding(.leading)
                            .sheet(isPresented: $settings, onDismiss: {
                                update(date: date)
                            }) {
                                Settings()
                            }
                        
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
            .sheet(isPresented: $location, onDismiss: {
                update(date: date)
            }) {
                Settings.Location()
                    .equatable()
            }
            .sheet(isPresented: $froob, content: Froob.init)
            .onChange(of: date) {
                update(date: $0)
                if Defaults.enableHaptics {
                    haptics.impactOccurred()
                }
            }
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
                
                update(date: date)
                
                if Defaults.enableHaptics {
                    haptics.prepare()
                }
            }
    }
    
    private func update(date: Date) {
        observatory.update(to: Defaults.coordinates)
        moon = observatory.moon(for: date)
    }
}
