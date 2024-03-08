import UIKit

extension UINavigationController {
    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
        replaceTopViewControllers(count: 1, with: [viewController], animated: animated)
    }
    
    func replaceTopViewControllers(count: Int, with viewControllers: [UIViewController], animated: Bool) {
        var vcs = self.viewControllers
        if count <= vcs.count {
            vcs.removeLast(count)
            vcs.append(contentsOf: viewControllers)
        } else {
            vcs = viewControllers
        }
        setViewControllers(vcs, animated: animated)
    }
}
