import XCTest
@testable import LastFmClient

class TopArtistsByCountryViewModelTests: XCTestCase {
    
    private var sut: TopArtistsByCountryViewModel!
    private let initTopArtistsResponse = TopArtistsResponse(topArtists: TopArtists(artist: [],
                                                                                   meta: TopArtistsMetaData(country: "",
                                                                                                            page: "1",
                                                                                                            perPage: "50",
                                                                                                            totalPages: "2",
                                                                                                            total: "50")))
    
    override func setUp() {
        let topArtistsByCountryNavigator = TopArtistsByCountryNavigator(navigationController: UINavigationController())
        let topArtistsByCountryRepository = TopArtistsByCountryRepository()
        sut = TopArtistsByCountryViewModel(topArtistsByCountryNavigator: topArtistsByCountryNavigator,
                                           topArtistsByCountryRepository: topArtistsByCountryRepository,
                                           country: "Bosnia and Herzegovina")
    }
    
    func testInitialState() {
        XCTAssertEqual(sut.isLoading, true)
        XCTAssertEqual(sut.isPaginating, false)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertEqual(sut.country, "Bosnia and Herzegovina")
        XCTAssertEqual(sut.topArtists, initTopArtistsResponse)
    }
    
    func testTopArtistsFetching() {
        let expectation = expectation(description: "Getting artists")
        var apiResult: DispatchTimeoutResult?
        var fetchedArtists: TopArtistsResponse = initTopArtistsResponse
        
        sut.getTopArtists() { result in
            expectation.fulfill()
            switch result {
            case .success(let artists):
                fetchedArtists = artists
                apiResult = .success
            case .failure(_):
                apiResult = .timedOut
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        if apiResult == .success {
            XCTAssertEqual(sut.topArtists, fetchedArtists)
            XCTAssertEqual(sut.isLoading, false)
        } else {
            XCTAssert(fetchedArtists.topArtists.artist.isEmpty)
        }
    }
}
