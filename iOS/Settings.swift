import SwiftUI

struct Settings: View {
    @State private var location = false
    @State private var traits = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section("Personalize") {
                    Button {
                        location = true
                    } label: {
                        Option(title: "Location",
                               subtitle: "Accurately keep track of the Moon",
                               symbol: "location")
                    }
                    .sheet(isPresented: $location, content: Location.init)
                    
                    Button {
                        traits = true
                    } label: {
                        Option(title: "Traits",
                               subtitle: "Your tracking preferences",
                               symbol: "slider.vertical.3")
                    }
                    .sheet(isPresented: $traits, content: Traits.init)
                }
                .headerProminence(.increased)
                
                Effects()
                Delete()
                Notifications()
                
                Section("Moon Health") {
                    NavigationLink(destination: Plus()) {
                        Option(title: "The Dark Side of the Moon",
                               subtitle: "Support Moon Health",
                               symbol: "triangle.inset.filled")
                    }
                    
                    NavigationLink(destination: About()) {
                        Option(title: "About",
                               subtitle: "App details",
                               symbol: "moon.circle")
                    }
                    
                    NavigationLink(destination: Info(title: "Privacy policy", text: Copy.privacy)) {
                        Option(title: "Privacy policy",
                               subtitle: "What we do with your data",
                               symbol: "hand.raised")
                    }
                }
                .headerProminence(.increased)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 21).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.primary)
                            .frame(width: 26, height: 40)
                            .padding(.leading)
                            .contentShape(Rectangle())
                    }
                }
            }
            .task {
                let model = await cloud.model
                if model.settings.traits.isEmpty {
                    traits = true
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
