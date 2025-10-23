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
}
