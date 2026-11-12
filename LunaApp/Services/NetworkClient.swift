import Foundation

// MARK: - Protocol

protocol NetworkClientProtocol {
    func fetch<T: Decodable>(_ request: URLRequest) async throws -> T
}

// MARK: - Errors

enum NetworkError: LocalizedError {
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            String(localized: .errorInvalidResponse)
        case .httpError(let statusCode):
            String(localized: .errorHttpError(statusCode))
        case .decodingError(_):
            String(localized: .errorDecodingError)
        }
    }
}

final class NetworkClient: NetworkClientProtocol {
    
    // MARK: - Private Properties
    
    private let session: URLSession
    
    // MARK: - Init
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Public Methods
    
    func fetch<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(response.statusCode) else {
            throw NetworkError.httpError(statusCode: response.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
}
