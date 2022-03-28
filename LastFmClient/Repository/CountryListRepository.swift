import Foundation

typealias CountryListCallback = (Result<[Country], ApiError>) -> Void

protocol CountryListRepositoryProtocol {
    func getCountryList(completion: @escaping CountryListCallback)
}

class CountryListRepository: CountryListRepositoryProtocol {

    static let shared = CountryListRepository()

    func getCountryList(completion: @escaping CountryListCallback) {
        ApiClient.shared.fetch(ApiRouter.countryList, dataType: [Country].self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
