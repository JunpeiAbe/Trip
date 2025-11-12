import SwiftUI

@MainActor @Observable
final class MainViewState {
    /// 画面遷移を管理するRouter
    private let router: AppRouter
    /// アラートが表示されているかどうか
    /// - note: 複数のアラートが表示されるのを防ぐため一つの状態として表示中かどうかを管理する
    // - TODO: 画面単位ではなくRootViewで一括管理する。画面で行うのはalertStateの更新のみ
    var alertState: AlertState = .dismissed
    var alertContent: AlertContent {
        alertState.alertType?.content ?? .init(title: "不正なエラー", message: "メッセージ", onTapCancelButton: {}, onTapOKButton: {})
    }
    var isShowAlert: Bool {
        alertState != .dismissed
    }
    
    init(
        router: AppRouter
    ) {
        self.router = router
    }
    /// エラーアラート表示ボタンタップ
    func showErrorAlertButtonPressed() {
        alertState = 
            .presenting(
                .error(
                    .init(
                        title: "エラー",
                        message: "メッセージ",
                        errorCode: "エラーコード:000000",
                        onTapCancelButton: { self.alertState = .dismissed },
                        onTapOKButton: { self.alertState = .dismissed }
                    )
                )
            )
    }
    /// 確認アラート表示ボタンタップ
    func showConfirmAlertButtonPressed() {
        alertState =
            .presenting(
                .error(
                    .init(
                        title: "確認",
                        message: "メッセージ",
                        errorCode: nil,
                        onTapCancelButton: { self.alertState = .dismissed },
                        onTapOKButton: { self.alertState = .dismissed }
                    )
                )
            )
    }
    /// 詳細画面に遷移
    func detailButtonPressed() {
        router.push(.detail)
    }
    /// 初期表示
    func onAppear() {
        Task {
            try await Task.sleep(nanoseconds: 10_000_000_000)
            alertState =
                .presenting(
                    .warning(
                        .init(
                            title: "警告",
                            message: "メッセージ",
                            errorCode: nil,
                            onTapCancelButton: { self.alertState = .dismissed },
                            onTapOKButton: { self.alertState = .dismissed }
                        )
                    )
                )
        }
    }
}
