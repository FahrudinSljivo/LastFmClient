import Foundation

typealias ArtistDetailsCallback = (Result<ArtistDetailsResponse, ApiError>) -> Void

protocol ArtistDetailsRepositoryProtocol {
    func getArtistDetails(artist: String, completion: @escaping ArtistDetailsCallback)
}

class ArtistDetailsRepository: ArtistDetailsRepositoryProtocol {

    static let shared = ArtistDetailsRepository()

    func getArtistDetails(artist: String, completion: @escaping ArtistDetailsCallback) {
        ApiClient.shared.fetch(ApiRouter.artistDetails(artist), dataType: ArtistDetailsResponse.self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
