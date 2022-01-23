import Foundation
import Selene

extension Track {
    final class Status: ObservableObject {
        @Published var preferences = false
        @Published var selected: Trait?
        @Published private(set) var items = [Trait : Double]()
        
        
        func update() async {
            let model = await cloud.model
//            traits = model
//                .settings
//                .traits
//                .filter {
//                    $0.active
//                }
//                .map {
//                    $0.id
//                }
            
//            preferences = true
        }
    }
}
