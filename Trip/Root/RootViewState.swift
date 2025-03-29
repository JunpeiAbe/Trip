import Foundation

@MainActor @Observable
final class RootViewState {
    
    var router: AppRouter
    
    let loginStore: LoginStore
    
    var loginContext: LoginContext? {
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
}
