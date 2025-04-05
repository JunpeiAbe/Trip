import SwiftUI

@MainActor @Observable
final class LoginStore {
    
    @AppStorage private(set) var value: AuthResponse?
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    /// ログイン
    func logIn(email: String, password: String) async throws {
        let authResponse = try await authRepository.logIn(email: email, password: password)
        value = authResponse
    }
    /// ログアウト
    func logOut() {
        value = nil
    }
    
    func checkTokenExpireDate() -> Bool {
        // 保存済みのアクセストークンがあるかどうか
        guard let accessToken = value?.accessToken, !accessToken.isEmpty else { return false }
        // アクセストークンの有効期限が切れていないかどうか
        return true
    }
}

