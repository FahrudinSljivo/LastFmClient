import Foundation
import UIKit

class ActivityIndicatorContainer: UIView {

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.color = .gray
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        addSubview(activityIndicator)
        activityIndicator
            .centerYAnchor
            .constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator
            .centerXAnchor
            .constraint(equalTo: centerXAnchor).isActive = true
    }
}
