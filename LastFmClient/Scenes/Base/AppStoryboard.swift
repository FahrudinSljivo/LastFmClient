import UIKit

enum AppStoryboard: String {

    case welcome = "Welcome"
    case countryList = "CountryList"
    case topArtistsByCountry = "TopArtistsByCountry"
    case detailsScreen = "DetailsScreen"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
