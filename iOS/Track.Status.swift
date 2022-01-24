import Foundation
import Combine
import Selene

extension Track {
    final class Status: ObservableObject {
        @Published var preferences = false
        @Published var trait: Trait?
        @Published var level: Level?
        @Published var previous: Trait?
        @Published private(set) var traits = [Trait]()
        @Published private(set) var journal: Journal?
        let day = Date.now.journal
        private var first = true
        private var subs = Set<AnyCancellable>()
        
        init() {
            print("status init")
            
            cloud
                .sink { [weak self] model in
                    guard let self = self else { return }
                    
                    self.traits = Trait
                        .allCases
                        .filter {
                            model.settings.traits.contains($0)
                        }
                        .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
                    
                    self.journal = model.journal[self.day]
                    
                    if self.first && self.traits.isEmpty {
                        self.preferences = true
                    }
                }
                .store(in: &subs)
        }
        
        deinit {
            print("status gone")
        }
    }
}
