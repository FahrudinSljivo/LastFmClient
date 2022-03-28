import UIKit

class TopArtistsByCountryNavigator: AppNavigator {
    
    func goToDetailsScreen(artist: String) {
        let detailsScreenViewController = DetailsScreenViewController.instantiateFromAppStoryboard(appStoryboard: .detailsScreen)
        let artistDetailsRepository = ArtistDetailsRepository()
        detailsScreenViewController.viewModel = DetailsScreenViewModel(artistDetailsRepository: artistDetailsRepository, artist: artist)

        navigationController?.pushViewController(detailsScreenViewController, animated: true)
    }
}
