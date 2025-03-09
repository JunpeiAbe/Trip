import SwiftUI

@MainActor @Observable
final class MainViewState {
    /// ログアウトボタンタップ
    func logOutButtonPressed() {
        LoginStore.shared.logOut()
    }
}
