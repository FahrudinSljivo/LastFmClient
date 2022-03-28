import Foundation
import Alamofire

enum ApiRouter {
    
    case countryList
    case topArtistsByCountry(String, Int)
    case artistDetails(String)
    
    var baseUrl: String {
        switch self {
        case .countryList:
            return "https://restcountries.com/v2/all/"
        default:
            return "http://ws.audioscrobbler.com/2.0/"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .topArtistsByCountry(let country, let page):
            return ["method": "geo.gettopartists", "country": country, "api_key": AppConfig.APIkey.rawValue, "format": "json", "page": page, "limit": "20"]
        case .artistDetails(let artist):
            return ["method": "artist.getinfo", "artist": artist, "api_key": AppConfig.APIkey.rawValue, "format": "json"]
        default:
            return [:]
        }
    }
}

extension ApiRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var request = URLRequest(url: url)
        request.method = .get
        
        request = try Alamofire.URLEncoding.default.encode(request, with: parameters)

        return request
    }
}
