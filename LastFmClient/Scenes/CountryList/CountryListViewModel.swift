import Foundation
import UIKit

protocol CountryListViewControllerDelegate: AnyObject {
    func reloadTableView()
}

class CountryListViewModel: AppViewModel {
    
    let countryListNavigator: CountryListNavigator
    let countryListRepository: CountryListRepository
    weak var delegate: CountryListViewControllerDelegate?
    
    var allCountries: [Country] = []
    var filteredCountries: [Country] = []
    
    init(countryListNavigator: CountryListNavigator, countryListRepository: CountryListRepository) {
        self.countryListNavigator = countryListNavigator
        self.countryListRepository = countryListRepository
    }
    
    func getCountries(completion: ((Result<[Country], ApiError>) -> ())? = nil) {
        countryListRepository.getCountryList { [weak self] result in
            switch result {
            case .success(let countries):
                self?.allCountries = countries
                self?.filteredCountries = countries
                self?.isLoading = false
                self?.delegate?.reloadTableView()
            case .failure(let error):
                self?.handleApiError(error)
            }
            if let completion = completion {
                completion(result)
            }
        }
    }
    
    func goToTopArtistsByCountry(country: String) {
        countryListNavigator.goToTopArtistsByCountryScreen(country: country)
    }
    
    func filterCurrentDataSource(searchTerm: String) {
        if searchTerm.count > 0 {
            filteredCountries = allCountries
            
            let filteredResults = filteredCountries.filter {
                $0.name.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
            }
            
            filteredCountries = filteredResults
            delegate?.reloadTableView()
        }
    }
    
    func restoreCurrentDataSource() {
        filteredCountries = allCountries
        delegate?.reloadTableView()
    }
}
