import UIKit

private let minHorizontalSpacing: CGFloat = 20

class HudView: UIView {
    enum HudPosition {
        case top(inset: CGFloat)
        case center
        case bottom(inset: CGFloat)
    }
    
    struct HudConfiguration {
        let backgroundColor: UIColor
        let textColor: UIColor
        let font: UIFont
        let position: HudPosition
        let padding: UIEdgeInsets
        let duration: CGFloat
        
        init(backgroundColor: UIColor = .black,
             textColor: UIColor = .white,
             font: UIFont = .systemFont(ofSize: 16),
             position: HudPosition = .center,
             padding: UIEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20),
             duration: CGFloat = 2) {
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.font = font
            self.position = position
            self.padding = padding
            self.duration = duration
        }
    }
    
    class func showProgress(in view: UIView?) {
        guard let view = view else { return }
        let hud = HudView(frame: view.bounds)
        let activityIndicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        hud.addSubview(activityIndicator)
        activityIndicator.center = hud.center
        activityIndicator.startAnimating()
        
        hud.backgroundColor = .black.withAlphaComponent(0.1)
        hud.alpha = 0
        view.addSubview(hud)
        
        UIView.animate(withDuration: 0.2, animations: {
            hud.alpha = 1
        })
    }
    
    class func hideProgress(in view: UIView?) {
        guard let view = view else { return }
        for subview in view.subviews {
            if subview.isKind(of: HudView.self) {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0
                }) { [weak subview] _ in
                    subview?.removeFromSuperview()
                }
            }
        }
    }
    
    class func showText(_ text: String, in view: UIView?, configuration: HudConfiguration) {
        guard let view = view else { return }
        let hud = HudView(frame: HudView.prefferedFrame(for: text, in: view, configuration: configuration))
        hud.addLabel(withText: text, configuration: configuration)
        hud.backgroundColor = configuration.backgroundColor
        hud.layer.cornerRadius = 5
        hud.alpha = 0
        view.addSubview(hud)
        
        UIView.animate(withDuration: 0.2, animations: {
            hud.alpha = 1
        }) { (finished) in
            if finished {
                UIView.animate(withDuration: 0.2, delay: TimeInterval(configuration.duration), options: .curveEaseInOut, animations: {
                    hud.alpha = 0
                }, completion: { (_) in
                    hud.removeFromSuperview()
                })
            }
        }
    }
    
    private func addLabel(withText text: String, configuration: HudConfiguration) {
        let label = UILabel(frame: CGRect(
            x: configuration.padding.left,
            y: configuration.padding.top,
            width: frame.width - configuration.padding.left - configuration.padding.right,
            height: frame.height - configuration.padding.top - configuration.padding.bottom))
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = configuration.font
        label.textColor = configuration.textColor
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
    }

    class private func prefferedFrame(for text: String, in view: UIView, configuration: HudConfiguration) -> CGRect {
        let width = min(text.width(withConstrainedHeight: .greatestFiniteMagnitude, font: configuration.font), view.bounds.width - configuration.padding.left - configuration.padding.right - 2*minHorizontalSpacing)
        let height = text.height(withConstrainedWidth: width, font: configuration.font)
        switch configuration.position {
        case .bottom(let inset):
            return CGRect(
                x: (view.bounds.width - width - configuration.padding.left - configuration.padding.right)/2,
                y: view.bounds.height - inset - height - configuration.padding.top - configuration.padding.bottom,
                width: width + configuration.padding.left + configuration.padding.right,
                height: height + configuration.padding.top + configuration.padding.bottom)
        case .center:
            return CGRect(
                x: (view.bounds.width - width - configuration.padding.left - configuration.padding.right)/2,
                y: (view.bounds.height - height)/2,
                width: width + configuration.padding.left + configuration.padding.right,
                height: height + configuration.padding.top + configuration.padding.bottom)
        case .top(let inset):
            return CGRect(
                x: (view.bounds.width - width - configuration.padding.left - configuration.padding.right)/2,
                y: inset,
                width: width + configuration.padding.left + configuration.padding.right,
                height: height + configuration.padding.top + configuration.padding.bottom)
        }
    }
    
}

fileprivate extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
