import XCTest
@testable import LastFmClient

class DetailsScreenViewModelTests: XCTestCase {
    
    private var sut: DetailsScreenViewModel!
    private let initArtistDetailsResponse = ArtistDetailsResponse(artist: ArtistDetails(name: "",
                                                                                     image: [],
                                                                                     stats: ArtistStats(listeners: "", playcount: ""),
                                                                                     similar: SimilarArtists(artist: []),
                                                                                     bio: ArtistBio(summary: "")))
    
    override func setUp() {
        let detailsScreenRepository = ArtistDetailsRepository()
        sut = DetailsScreenViewModel(artistDetailsRepository: detailsScreenRepository, artist: "Queen")
    }
    
    func testInitialState() {
        XCTAssertEqual(sut.artist, "Queen")
        XCTAssertEqual(sut.artistDetails, initArtistDetailsResponse)
        XCTAssertEqual(sut.isLoading, true)
    }
    
    func testArtistDetailsFetching() {
        let expectation = expectation(description: "Getting artist details")
        var apiResult: DispatchTimeoutResult?
        var artistDetails: ArtistDetailsResponse = initArtistDetailsResponse
        
        sut.getArtistDetails("Queen") { result in
            expectation.fulfill()
            switch result {
            case .success(let details):
                artistDetails = details
                apiResult = .success
            case .failure(_):
                apiResult = .timedOut
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        if apiResult == .success {
            XCTAssertEqual(sut.artistDetails.artist.name, artistDetails.artist.name)
            XCTAssertEqual(sut.artistDetails.artist.image, artistDetails.artist.image)
            XCTAssertEqual(sut.artistDetails.artist.stats, artistDetails.artist.stats)
            XCTAssertEqual(sut.artistDetails.artist.similar, artistDetails.artist.similar)
            XCTAssertEqual(sut.artistDetails.artist.bio.summary, artistDetails.artist.bio.summary.withoutHtml)
            XCTAssertEqual(sut.isLoading, false)
        } else {
            XCTAssertNil(sut.artistDetails)
        }
    }
}
