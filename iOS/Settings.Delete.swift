import SwiftUI
import Selene

extension Settings {
    struct Delete: View {
        @State private var trait = false
        @State private var all = false
        
        var body: some View {
            Section("Data") {
                Button {
                    trait = true
                } label: {
                    Option(title: "Delete trait",
                           subtitle: "Clear your data from 1 trait",
                           symbol: "delete.backward")
                }
                .alert("What trait to delete?", isPresented: $trait) {
                    Button("Cancel", role: .cancel) {
                        
                    }
                    
                    ForEach(Trait.allCases.sorted(), id: \.self) { trait in
                        Button(trait.title, role: .destructive) {
                            Task {
                                await cloud.delete(trait: trait)
                                await UNUserNotificationCenter.send(message: "Deleted \(trait.title) data!")
                            }
                        }
                    }
                }
                
                Button {
                    all = true
                } label: {
                    Option(title: "Delete everything",
                           subtitle: "To have a completely fresh start",
                           symbol: "trash")
                }
                .alert("Delete everything?", isPresented: $all) {
                    Button("Cancel", role: .cancel) {
                        
                    }
                    
                    Button("Delete", role: .destructive) {
                        Task {
                            await cloud.delete()
                            await UNUserNotificationCenter.send(message: "Deleted all data!")
                        }
                    }
                }
            }
            .headerProminence(.increased)
        }
    }
}
