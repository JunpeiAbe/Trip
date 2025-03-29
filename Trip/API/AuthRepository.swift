import Foundation
@MainActor
protocol AuthRepositoryProtocol {
    func logIn(email: String, password: String) async throws -> AuthResponse
}

struct AuthRepository: AuthRepositoryProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func logIn(email: String, password: String) async throws -> AuthResponse {
        let request: AuthRequest = .init(mailAddress: email, password: password)
        let response = try await APIClient.send(request)
        return response
    }
}

struct StubAuthRepository_Success: AuthRepositoryProtocol {
    func logIn(email: String, password: String) async throws -> AuthResponse {
        try await Task.sleep(nanoseconds: 5_000_000_000)
        return .init(
            accessToken: UUID().uuidString,
            refreshToken: UUID().uuidString,
            expireDate: "1234567"
        )
    }
}

struct StubAuthRepository_Failure: AuthRepositoryProtocol {
    func logIn(email: String, password: String) async throws -> AuthResponse {
        try await Task.sleep(nanoseconds: 5_000_000_000)
        throw APIClientError.invalidResponse(statusCode: 401)
    }
}

