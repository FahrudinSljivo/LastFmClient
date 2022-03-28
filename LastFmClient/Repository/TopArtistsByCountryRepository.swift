import Foundation

typealias TopArtistsByCountryCallback = (Result<TopArtistsResponse, ApiError>) -> Void

protocol TopArtistsByCountryRepositoryProtocol {
    func getTopArtistsByCountry(of country: String, page: Int, completion: @escaping TopArtistsByCountryCallback)
}

class TopArtistsByCountryRepository: TopArtistsByCountryRepositoryProtocol {

    static let shared = TopArtistsByCountryRepository()

    func getTopArtistsByCountry(of country: String, page: Int, completion: @escaping TopArtistsByCountryCallback) {
        ApiClient.shared.fetch(ApiRouter.topArtistsByCountry(country, page), dataType: TopArtistsResponse.self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
