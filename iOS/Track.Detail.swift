import SwiftUI
import Selene

extension Track {
    struct Detail: View {
        let trait: Trait
        let animation: Namespace.ID
        let back: () -> Void
        @State private var slide = 0.0
        
        var body: some View {
            ZStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: back) {
                                Image(systemName: "arrow.backward.circle.fill")
                                    .font(.system(size: 26).weight(.light))
                                    .symbolRenderingMode(.hierarchical)
                                    .frame(width: 40, height: 40)
                                    .padding(.leading)
                            }
                            Spacer()
                        }
                        HStack {
                            Image(systemName: trait.image)
                                .resizable()
                                .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 18)
                                .foregroundColor(trait.color)
                            Text(trait.title)
                                .matchedGeometryEffect(id: "\(trait).text", in: animation)
                                .font(.footnote)
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 34).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.pink)
                    }
                    .padding(.bottom, 30)
                }
                
                HStack(spacing: 0) {
                    ForEach(0 ..< 5) { index in
                        Item(index: index, trait: trait) {
                            
                        }
                    }
                }
            }
        }
    }
}
