import UIKit

extension UIViewController {
    // MARK: - Helping Navigation Methods
    func topNonNavigationParent() -> UIViewController {
        var topParent = self
        while let nextParent = topParent.parent, (nextParent as? UINavigationController) == nil {
            topParent = nextParent
        }
        
        return topParent
    }
}
