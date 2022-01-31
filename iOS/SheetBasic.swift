import SwiftUI

final class SheetBasic<C>: UIHostingController<C>, UIViewControllerRepresentable where C : View {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetPresentationController
            .map {
                $0.detents = [.medium(), .large()]
            }
    }
    
    func makeUIViewController(context: Context) -> SheetBasic {
        self
    }
    
    func updateUIViewController(_: SheetBasic, context: Context) {
        
    }
}
