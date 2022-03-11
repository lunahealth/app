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
            let file = Bundle.main.url(forResource: "Basso", withExtension: "aiff"),
            let item = try? AVAudioPlayer(contentsOf: file)
        else { return }
        
        items.insert(item)
        item.play()
    }
}
