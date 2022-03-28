import XCTest
@testable import LastFmClient

class CountryListViewModelTests: XCTestCase {

    private var sut: CountryListViewModel!
    
    override func setUp() {
        let countryListNavigator = CountryListNavigator(navigationController: UINavigationController())
        let countryListRepository = CountryListRepository()
        sut = CountryListViewModel(countryListNavigator: countryListNavigator, countryListRepository: countryListRepository)
    }
    
    func testInitialState() {
        XCTAssertEqual(sut.isLoading, true)
        XCTAssertEqual(sut.allCountries, [])
        XCTAssertEqual(sut.filteredCountries, [])
    }
    
    func testCountriesFetching() {
        let expectation = expectation(description: "Getting countries")
        var apiResult: DispatchTimeoutResult?
        var fetchedCountries: [Country] = []
        
        sut.getCountries { result in
            expectation.fulfill()
            switch result {
            case .success(let countries):
                fetchedCountries = countries
                apiResult = .success
            case .failure(_):
                apiResult = .timedOut
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        if apiResult == .success {
            XCTAssertEqual(sut.allCountries, fetchedCountries)
            XCTAssertEqual(sut.filteredCountries, fetchedCountries)
            XCTAssertEqual(sut.isLoading, false)
        } else {
            XCTAssert(fetchedCountries.isEmpty)
        }
    }
    
    func testCountriesFiltering() {
        let countries: [Country] = [Country(name: "Austria", flag: ""),
                                    Country(name: "Bosnia and Herzegovina", flag: ""),
                                    Country(name: "Germany", flag: ""),
                                    Country(name: "Switzerland", flag: "")]
        sut.allCountries = countries
        sut.filterCurrentDataSource(searchTerm: "Bosn")
        XCTAssert(!sut.filteredCountries.isEmpty)
        sut.filterCurrentDataSource(searchTerm: "Aosn")
        XCTAssert(sut.filteredCountries.isEmpty)
    }
    
    func testCountriesRestoring() {
        sut.restoreCurrentDataSource()
        XCTAssertEqual(sut.allCountries, sut.filteredCountries)
    }
}
