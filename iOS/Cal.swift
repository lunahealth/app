import SwiftUI
import Selene

struct Cal: View {
    weak var observatory: Observatory!
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("January 2022")
                }
                .padding(.top, 30)
                Spacer()
            }
            
            Ring(observatory: observatory)
        }
    }
}
