import UIKit

public protocol BaseView: AnyObject {
    func open(module: BaseModule)
    func showChild(module: BaseModule)
    func present(module: BaseModule)
    func replace(with module: BaseModule, animated: Bool)
    func openAsRoot(module: BaseModule)
    func closeModule(animated: Bool)
    func closeToRoot(animated: Bool)
    func closeToView(view: BaseView?, animated: Bool)
    func showProgress()
    func hideProgress()
    func showError(error: String)
    func showMessage(message: String)
    func showSuccessMessage(message: String)
}
