import Foundation
import Combine
import Selene

extension Track {
    final class Status: ObservableObject {
        @Published var preferences = false
        @Published var trait: Trait?
        @Published var level: Level?
        @Published var first = true
        @Published private(set) var traits = [Trait]()
        @Published private(set) var journal: Journal?
        private var subs = Set<AnyCancellable>()
        private let date = Date.now
        
        init() {
            cloud
                .sink { [weak self] model in
                    guard let self = self else { return }
                    
                    self.traits = Trait
                        .allCases
                        .filter {
                            model.settings.traits.contains($0)
                        }
                        .sorted()
                    
                    self.journal = model[self.date]
                }
                .store(in: &subs)
        }
    }
}
