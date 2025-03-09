import Foundation
@MainActor
protocol AuthRepositoryProtocol {
    func logIn(email: String, password: String) async throws -> AccessToken?
}

struct AuthRepository: AuthRepositoryProtocol {
    func logIn(email: String, password: String) async throws -> AccessToken? {
        let token = try await APIClient.logIn(email: email, password: password)
        return token
    }
}

