import SwiftUI

@MainActor @Observable
final class LoginStore {
    
    static let shared: LoginStore = .init()
    
    private(set) var value: LoginContext?
    
    func logIn(email: String, password: String) async throws {
        guard let accessToken = try await AuthRepository.logIn(email: email, password: password) else { return }
        value = LoginContext(accessToken: accessToken)
    }
    
    func logOut() {
        value = nil
    }
}

