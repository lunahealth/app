import SwiftUI

final class Sheet<C>: UIHostingController<C>, UIViewControllerRepresentable where C : View {
    required init?(coder: NSCoder) { nil }
    override init(rootView: C) {
        super.init(rootView: rootView)
//        modalPresentationStyle = .overCurrentContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetPresentationController
            .map {
                $0.detents = [.medium()]
            }
    }
    
    override func willMove(toParent: UIViewController?) {
        super.willMove(toParent: toParent)
        parent?.modalPresentationStyle = .overCurrentContext
        parent?.view.backgroundColor = .clear
        view.backgroundColor = .clear
    }
    
    func makeUIViewController(context: Context) -> Sheet {
        self
    }
    
    func updateUIViewController(_: Sheet, context: Context) {
        
    }
}
