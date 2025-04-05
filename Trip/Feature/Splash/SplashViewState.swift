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
        // アクセストークンが保存済み かつ 有効期限内の場合
        if loginStore.checkTokenExpireDate() {
            router.push(.main)
        } else {
            router.push(.login)
        }
    }
}
