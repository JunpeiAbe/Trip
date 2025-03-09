import SwiftUI

@MainActor @Observable
final class DetailViewState {
    let router: AppRouter // ✅ 画面遷移を管理する Router
    
    init(router: AppRouter) {
        self.router = router
    }
    /// ログアウトボタンタップ
    func logOutButtonPressed() {
        LoginStore.shared.logOut()
        router.popToRoot()
    }
}

