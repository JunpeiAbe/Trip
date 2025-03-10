import SwiftUI

@MainActor @Observable
final class MainViewState {
    let router: AppRouter // ✅ 画面遷移を管理する Router
    
    init(router: AppRouter) {
        self.router = router
    }
    /// ログアウトボタンタップ
    func logOutButtonPressed() {
        LoginStore.shared.logOut()
        router.pop()
    }
    /// 詳細画面に遷移
    func detailButtonPressed() {
        router.push(.detail)
    }
}
