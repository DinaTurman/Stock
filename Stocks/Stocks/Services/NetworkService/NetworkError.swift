

import Foundation

enum NetworkError: String, Error {
    case missingURL
    case missingRequest
    case taskError
    case responseError
    case dataError
    case decodeError
}
