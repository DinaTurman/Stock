
//Create URL Request
import Foundation

protocol Router {
    typealias Headers = [String: String]
    typealias Parameters = [String: Any]
    typealias Body = [String: Any?]
    
    var baseUrl: String { get }
    var path: String { get }
    var headers: Headers { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var body: Body { get }
    
    func request() throws -> URLRequest
}

extension Router {
    var headers: Headers {
        [:]
    }
    
    //post request
    var body: Body {
        [:]
    }
  
    // преобразование из словаря body в data
    var httpBody: Data? {
        if body.isEmpty { return nil }
        return try? JSONSerialization.data(withJSONObject: body, options: [])
    }
}

// дефолтная реализация
extension Router {
    func request() throws -> URLRequest {
        //path parameters come before the question mark sign.
        let urlString = baseUrl + path
        guard let url = URL(string: urlString) else {
            throw NetworkError.missingURL
        }
        //Создает и инициализирует URL-запрос с заданным URL, политикой кэширования и интервалом тайм-аута.
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        
        addHeaders(to: &request)
        try addParameters(to: &request)
        
        return request
    }


    private func addParameters(to request: inout URLRequest) throws {
        guard let url = request.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            //Query parameters are appended to the end of the URL, using a ‘?’
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
    }
    
    private func addHeaders(to request: inout URLRequest) {
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
