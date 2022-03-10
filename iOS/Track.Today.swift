import SwiftUI

extension Track {
    struct Today: View {
        @ObservedObject var status: Status
        let animation: Namespace.ID
        
        var body: some View {
            if !status.traits.isEmpty && status.traits.count <= (status.journal?.traits.count ?? 0) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 35).weight(.light))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.accentColor)
                    .foregroundStyle(.primary)
                    .padding(.bottom, 2)
                Text("Completed")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
            }
            ForEach(status.traits, id: \.self) { trait in
                Category(status: status, trait: trait, animation: animation)
            }
        }
    }
}
