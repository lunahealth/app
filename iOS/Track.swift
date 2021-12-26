import SwiftUI
import Selene

struct Track: View {
    @Binding var date: Date
    let week: [Day]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                Header(date: $date, week: week)
            }
            .navigationTitle("Track")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
