import SwiftUI

final class SheetMinimal<C>: UIHostingController<C>, UIViewControllerRepresentable where C : View {
    required init?(coder: NSCoder) { nil }
    override init(rootView: C) {
        super.init(rootView: rootView)
        modalPresentationStyle = .overCurrentContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetPresentationController
            .map {
                $0.detents = [.medium()]
                $0.preferredCornerRadius = 40
                $0.prefersGrabberVisible = true
            }
    }
    
    override func willMove(toParent: UIViewController?) {
        super.willMove(toParent: toParent)
        parent?.view.backgroundColor = .clear
        view.backgroundColor = .clear
    }
    
    func makeUIViewController(context: Context) -> SheetMinimal {
        self
    }
    
    func updateUIViewController(_: SheetMinimal, context: Context) {
        
    }
}
