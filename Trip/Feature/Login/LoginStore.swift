import SwiftUI

@MainActor @Observable
final class LoginStore {
    
    private(set) var value: LoginContext?
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func logIn(email: String, password: String) async throws {
        let accessToken = try await authRepository.logIn(email: email, password: password).accessToken
        value = LoginContext(accessToken: accessToken)
    }
    
    func logOut() {
        value = nil
    }
}

