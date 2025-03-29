import Foundation
@MainActor @Observable
final class SplashViewState {
    /// 画面遷移を管理するRouter
    private let router: AppRouter
    /// ストア
    private let loginStore: LoginStore
    
    init(
        router: AppRouter,
        loginStore: LoginStore
    ) {
        self.router = router
        self.loginStore = loginStore
    }
    
    func firstLoad() {
        router.push(.login)
    }
}
