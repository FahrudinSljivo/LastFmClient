import Foundation

protocol TopArtistsByCountryViewControllerDelegate: AnyObject {
    func reloadTableView()
}

class TopArtistsByCountryViewModel: AppViewModel {
    
    let topArtistsByCountryNavigator: TopArtistsByCountryNavigator
    let topArtistsByCountryRepository: TopArtistsByCountryRepository
    let country: String
    var currentPage = 1
    var isPaginating = false
    
    
    weak var delegate: TopArtistsByCountryViewControllerDelegate?
    var topArtists = TopArtistsResponse(topArtists: TopArtists(artist: [],
                                                               meta: TopArtistsMetaData(country: "", page: "1", perPage: "50", totalPages: "2", total: "50")))
    
    init(topArtistsByCountryNavigator: TopArtistsByCountryNavigator,
         topArtistsByCountryRepository: TopArtistsByCountryRepository,
         country: String) {
        self.topArtistsByCountryNavigator = topArtistsByCountryNavigator
        self.topArtistsByCountryRepository = topArtistsByCountryRepository
        self.country = country
    }
    
    func getTopArtists(completion: ((Result<TopArtistsResponse, ApiError>) -> ())? = nil) {
        topArtistsByCountryRepository.getTopArtistsByCountry(of: country, page: currentPage) { [weak self] result in
            switch result {
            case .success(let topArtists):
                if self?.currentPage == 1 {
                    self?.topArtists = topArtists
                    self?.isLoading = false
                } else {
                    self?.topArtists.topArtists.artist.append(contentsOf: topArtists.topArtists.artist)
                }
                self?.currentPage += 1
                self?.isPaginating = false
                self?.delegate?.reloadTableView()
            case .failure(let error):
                self?.handleApiError(error)
            }
            if let completion = completion {
                completion(result)
            }
        }
    }
    
    func goToDetailsScreen(artist: String) {
        topArtistsByCountryNavigator.goToDetailsScreen(artist: artist)
    }
}

