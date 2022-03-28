import UIKit

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiateFromAppStoryboard(appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
