import UIKit

class AppNavigator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func navigateToCountryListScreen() {
        let countryListViewController = CountryListViewController.instantiateFromAppStoryboard(appStoryboard: .countryList)
        let countryListNavigator = CountryListNavigator(navigationController: navigationController)
        let countryListRepository = CountryListRepository()
        countryListViewController.viewModel = CountryListViewModel(countryListNavigator: countryListNavigator, countryListRepository: countryListRepository)

        navigationController?.pushViewController(countryListViewController, animated: true)
    }
}
