import Foundation
import Combine
import Selene

extension Track {
    final class Status: ObservableObject {
        @Published var preferences = false
        @Published var trait: Trait?
        @Published var level: Level?
        @Published private(set) var traits = [Trait]()
        @Published private(set) var journal: Journal?
        let refresh = PassthroughSubject<Void, Never>()
        private var first = true
        private var subs = Set<AnyCancellable>()
        
        init() {
            cloud
                .combineLatest(refresh)
                .sink { [weak self] model, _ in
                    guard let self = self else { return }
                    
                    self.traits = Trait
                        .allCases
                        .filter {
                            model.settings.traits.contains($0)
                        }
                        .sorted()
                    
                    self.journal = model[.now]
                    
                    if self.first && self.traits.isEmpty {
                        self.first = false
                        self.preferences = true
                    }
                }
                .store(in: &subs)
        }
    }
}
