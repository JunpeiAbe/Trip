import SwiftUI

@MainActor @Observable
final class DetailViewState {
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
    /// ログアウトボタンタップ
    func logOutButtonPressed() {
        loginStore.logOut()
        router.pop(.login)
    }
}

