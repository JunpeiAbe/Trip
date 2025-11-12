import Foundation
import SwiftUI

@MainActor @Observable
final class RootViewState {
    
    var router: AppRouter
    
    let loginStore: LoginStore
    
    var isLoading: Bool = false
    
    var isShowDialog: Bool = false
    
    var isDialogChecked: Bool = false
    
    @ObservationIgnored @AppStorage("shouldShowDialogOnAppear") var shouldShowDialogOnAppear: Bool = true
    
    var loginContext: AuthResponse? {
        loginStore.value
    }
    
    var presentsLoginView: Bool {
        loginContext == nil
    }
    
    var alertContent: AlertContent? = nil
    var isShowAlert: Bool {
        alertContent != nil
    }
    
    init(
        router: AppRouter,
        loginStore: LoginStore
    ) {
        self.router = router
        self.loginStore = loginStore
    }
    
    func onTapDialogCloseButton() {
        isShowDialog = false
        // ダイアログのチェック状態を端末に保存
        isDialogChecked = isDialogChecked
    }
    
    func onForeground() {
        Task {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            let error = loginStore.throwsError()
            switch error {
                
            case .invalidURL, .requestFailed(_), .invalidResponse(statusCode: _), .decodingFailed:
                break
            case .notConnectedInternet:
                var alertContent = error.alertContent
                alertContent.onTapOKButton = {
                    Task { @MainActor in
                        self.router.popToRoot()
                    }
                }
                self.alertContent = alertContent
            }
        }
    }
    
    func onBackground() {
        alertContent = nil
    }
}
