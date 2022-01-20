import Foundation
import Combine
import Selene

extension TrackOld {
    final class Status: ObservableObject {
        @Published var items = [Item]() {
            didSet {
                update
                    .send(items
                            .filter {
                        $0.active
                    }
                            .reduce(.init()) {
                        $0.with(trait: $1.id, value: $1.value)
                    })
            }
        }
        
        let day: Day
        let traits = PassthroughSubject<[Trait], Never>()
        private let update = PassthroughSubject<Journal, Never>()
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
                            .init(active: journal?.traits[$0] != nil,
                                  value: .init(journal?.traits[$0] ?? 0),
                                  id: $0)
                        }
                }
                .assign(to: &$items)
            
            update
                .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                .removeDuplicates()
                .sink { journal in
                    Task {
                        await cloud.track(day: day, journal: journal)
                    }
                }
                .store(in: &subs)
        }
    }
}
