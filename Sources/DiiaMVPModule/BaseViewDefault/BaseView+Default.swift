import UIKit

public extension BaseView where Self: MVPBaseViewController {
    func open(module: BaseModule) {
        guard let navigation = navigationController else {
            return
        }
        // Pushing a navigation controller is not supported
        if (module.viewController() as? UINavigationController) == nil {
            navigation.pushViewController(module.viewController(), animated: true)
        } else if let navModule = (module.viewController() as? UINavigationController) {
            navigation.pushViewController(navModule.viewControllers[0], animated: true)
        }
    }

    func showChild(module: BaseModule) {
        view.endEditing(true)
        let child = module.viewController()
        let vc = self.topNonNavigationParent()
        vc.addChild(child)
        child.willMove(toParent: vc)

        vc.view.addSubview(child.view)
        [
            child.view.topAnchor.constraint(equalTo: vc.view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            child.view.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor)
        ].forEach { $0.isActive = true }

        child.didMove(toParent: vc)
    }

    func present(module: BaseModule) {
        let vc = module.viewController()
        if vc as? UINavigationController != nil {
            present(vc, animated: true, completion: nil)
            return
        }
        let nc = UINavigationController(rootViewController: vc)
        nc.isNavigationBarHidden = true
        nc.modalPresentationStyle = vc.modalPresentationStyle
        present(nc, animated: true, completion: nil)
    }

    func replace(with module: BaseModule, animated: Bool = true) {
        guard let navigation = navigationController,
              (module.viewController() as? UINavigationController) == nil
        else {
            return
        }
        navigation.replaceTopViewController(with: module.viewController(), animated: animated)
    }

    func openAsRoot(module: BaseModule) {
        let window: UIWindow? = UIApplication.shared.keyWindow
        window?.replaceRootViewControllerWith(module.viewController(), animated: true, completion: nil)
    }

    func closeModule(animated: Bool = true) {
        if let navigationController = navigationController,
           presentingViewController != nil, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: animated)
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: animated)
        }
    }

    func closeToRoot(animated: Bool = true) {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: animated)
        }
    }

    func closeToView(view: BaseView?, animated: Bool = true) {
        if let navigationController = navigationController,
           let topParent = (view as? UIViewController)?.topNonNavigationParent(),
           navigationController.viewControllers.contains(topParent) {
            navigationController.popToViewController(topParent, animated: animated)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    func showProgress() {
        let view = viewForHUD()
        HudView.showProgress(in: view)
    }

    func hideProgress() {
        let view = viewForHUD()
        HudView.hideProgress(in: view)
    }

    func showMessage(message: String) {
        HudView.showText(message, in: view, configuration: .init())
    }

    func showSuccessMessage(message: String) {
        HudView.showText(message, in: view, configuration: .init(backgroundColor: .systemGreen))
    }

    func showError(error: String) {
        HudView.showText(error, in: view, configuration: .init(backgroundColor: .systemRed))
    }

    // MARK: - Helping Methods
    private func viewForHUD() -> UIView {
        if let navigation = navigationController {
            return navigation.view
        } else {
            return view
        }
    }
}
