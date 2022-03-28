import Foundation
import Alamofire

class ApiClient {
    
    static let shared = ApiClient()

    let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30

        return Session(configuration: configuration)
    }()

    func fetch<T: Codable>(_ convertible: URLRequestConvertible,
                                  dataType: T.Type,
                                  completion: @escaping (Result<T, ApiError>) -> Void) {
        let isOnline = NetworkReachabilityManager()?.isReachable

        if isOnline == false {
            let error = ApiError(statusCode: 999, data: nil, error: nil)
            return completion(.failure(error))
        }

        session.request(convertible)
            .validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure:
                let apiError = ApiError(response: response.response,
                                        data: response.data,
                                        error: response.error)

                completion(.failure(apiError))
            }
        }
    }
}
