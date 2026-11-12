import Foundation

// MARK: - Protocol

protocol APIRequest {
    associatedtype DTO: Encodable
    
    static var baseURL: URL? { get }
    static var method: HTTPMethod { get }
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var bodyDTO: DTO? { get }
    
    func buildRequest() throws -> URLRequest
}

// MARK: - Default Implementation

extension APIRequest {
    static var baseURL: URL? { APIConfiguration.baseURL }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String: String]? { nil }
    var bodyDTO: DTO? { nil }
    
    func buildRequest() throws -> URLRequest {
        func formEndpoint() throws -> URL {
            guard let url = Self.baseURL?
                .appending(path: "api")
                .appending(path: path)
                .appending(queryItems: queryItems ?? [])
            else {
                throw RequestError.invalidEndpoint
            }
            return url
        }
        
        var request = URLRequest(url: try formEndpoint())
        request.httpMethod = Self.method.rawValue
        
        if let headers {
            request.allHTTPHeaderFields = headers
        }
        
        if let bodyDTO {
            do {
                request.httpBody = try JSONEncoder().encode(bodyDTO)
            } catch {
                throw RequestError.encodingError(error)
            }
        }
        
        return request
    }
}

// MARK: - Errors

enum RequestError: LocalizedError {
    case invalidEndpoint
    case encodingError(Error)
}

