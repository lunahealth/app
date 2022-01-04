import Foundation
import Combine
import Selene

extension Track {
    final class Status: ObservableObject {
        @Published var items = [Item]()
        let day: Day
        let traits = PassthroughSubject<[Trait], Never>()
        private var subs = Set<AnyCancellable>()
        
        init(day: Day) {
            self.day = day
            
            traits
                .removeDuplicates()
                .combineLatest(cloud
                                .map { $0.journal[day.journal] }
                                .removeDuplicates()) { traits, journal in
                    traits
                        .map {
                            .init(active: false,
                                  value: 0,
                                  id: $0)
                        }
                }
                .assign(to: &$items)
        }
    }
}
