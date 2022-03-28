import UIKit

class CountryListNavigator: AppNavigator {
    
    func goToTopArtistsByCountryScreen(country: String) {
        let topArtistsByCountryViewController = TopArtistsByCountryViewController.instantiateFromAppStoryboard(appStoryboard: .topArtistsByCountry)
        let topArtistsByCountryNavigator = TopArtistsByCountryNavigator(navigationController: navigationController)
        let topArtistsByCountryRepository = TopArtistsByCountryRepository()
        topArtistsByCountryViewController.viewModel = TopArtistsByCountryViewModel(topArtistsByCountryNavigator: topArtistsByCountryNavigator,
                                                                                   topArtistsByCountryRepository: topArtistsByCountryRepository,
                                                                                   country: country)
        navigationController?.pushViewController(topArtistsByCountryViewController, animated: true)
    }
}
