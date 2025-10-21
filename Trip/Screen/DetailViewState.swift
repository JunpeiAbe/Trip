import SwiftUI

@MainActor @Observable
final class DetailViewState {
    /// 画面遷移を管理するRouter
    private let router: AppRouter
    /// ストア
    private let loginStore: LoginStore
    /// ローディング表示するかどうか
    private(set) var isShowLoading: Bool = false
    
    init(
        router: AppRouter,
        loginStore: LoginStore
    ) {
        self.router = router
        self.loginStore = loginStore
    }
    /// ローディング表示ボタンタップ
    func didTapShowIndicatorButton() {
        isShowLoading = true
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            isShowLoading = false
        }
    }
}
