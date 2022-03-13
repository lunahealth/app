import AVFoundation

final class Audio {
    private var items = Set<AVAudioPlayer>()

    func play() {
        Task
            .detached(priority: .background) { [weak self] in
                self?.detachedPlay()
            }
    }
    
    private func detachedPlay() {
        guard
            let file = Bundle.main.url(forResource: "Tink", withExtension: "aiff"),
            let item = try? AVAudioPlayer(contentsOf: file)
        else { return }
        item.volume = 0.4
        items.insert(item)
        item.play()
    }
}
