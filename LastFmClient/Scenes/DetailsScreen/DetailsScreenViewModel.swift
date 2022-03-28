import Foundation

protocol DetailsScreenViewControllerDelegate: AnyObject {
    func refreshData()
}

class DetailsScreenViewModel: AppViewModel {
    
    let artistDetailsRepository: ArtistDetailsRepository
    let artist: String
    
    var artistDetails = ArtistDetailsResponse(artist: ArtistDetails(name: "",
                                                     image: [],
                                                     stats: ArtistStats(listeners: "", playcount: ""),
                                                     similar: SimilarArtists(artist: []),
                                                     bio: ArtistBio(summary: "")))
    
    weak var delegate: DetailsScreenViewControllerDelegate?
    
    init(artistDetailsRepository: ArtistDetailsRepository,
         artist: String) {
        self.artistDetailsRepository = artistDetailsRepository
        self.artist = artist
    }
    
    func getArtistDetails(_ artist: String, completion: ((Result<ArtistDetailsResponse, ApiError>) -> ())? = nil) {
        artistDetailsRepository.getArtistDetails(artist: artist) { [weak self] result in
            switch result {
            case .success(let artistDetails):
                self?.artistDetails = artistDetails
                self?.artistDetails.artist.bio.summary = artistDetails.artist.bio.summary.withoutHtml
                self?.isLoading = false
                self?.delegate?.refreshData()
            case .failure(let error):
                self?.handleApiError(error)
            }
            if let completion = completion {
                completion(result)
            }
        }
    }
}
