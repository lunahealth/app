import Foundation
import Selene

extension Track {
    final class Status: ObservableObject {
        @Published var preferences = false
        @Published private(set) var items = [Item]()
        @Published private(set) var waiting = [Trait]()
        
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
            
            preferences = true
        }
    }
}
