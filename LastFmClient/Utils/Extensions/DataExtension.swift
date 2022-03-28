import Foundation

extension Data {
    
    func decoded<T: Decodable>() throws -> T {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(T.self, from: self)
    }
}
