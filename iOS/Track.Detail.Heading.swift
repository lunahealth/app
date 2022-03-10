import SwiftUI
import Selene

extension Track.Detail {
    struct Heading: View {
        @ObservedObject var status: Track.Status
        let trait: Trait
        let animation: Namespace.ID
        
        var body: some View {
            ZStack(alignment: .top) {
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            status.trait = nil
                        }
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .font(.system(size: 28).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 45, height: 40)
                            .padding(.leading)
                    }
                    .tint(.primary)
                    .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    if status.journal?.traits[trait] != nil {
                        Button {
                            Task {
                                await cloud.remove(trait: trait)
                            }
                            
                            withAnimation(.easeInOut(duration: 0.4)) {
                                status.trait = nil
                            }
                        } label: {
                            Text("Clear")
                                .font(.callout)
                                .frame(maxWidth: 90)
                        }
                        .tint(.primary)
                        .foregroundStyle(.secondary)
                    }
                }
                
                VStack(spacing: 10) {
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.largeTitle.weight(.light))
                        .foregroundStyle(.secondary)
                        .foregroundColor(.primary)
                    Text(trait.title)
                        .matchedGeometryEffect(id: "\(trait).text", in: animation)
                        .font(.title3)
                        .minimumScaleFactor(0.1)
                }
                .padding(.top)
            }
            .padding(.top)
        }
    }
}
