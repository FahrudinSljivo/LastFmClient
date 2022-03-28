import Alamofire
import Foundation

class ApiError: Error {
    let response: HTTPURLResponse?
    let statusCodeValue: Int
    let data: Data?
    let error: Error?
    let errorBody: ErrorResponse?

    init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        self.response = response
        self.statusCodeValue = response?.statusCode ?? 0
        self.data = data
        self.error = error
        self.errorBody = try? data?.decoded()
    }

    init(statusCode: Int, data: Data?, error: Error?) {
        self.response = nil
        self.statusCodeValue = statusCode
        self.data = data
        self.error = error
        self.errorBody = try? data?.decoded()
    }
}
