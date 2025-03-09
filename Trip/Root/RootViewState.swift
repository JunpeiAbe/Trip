import Foundation

@MainActor @Observable
final class RootViewState {
    
    var router = AppRouter() 
    
    var loginContext: LoginContext? {
        LoginStore.shared.value
    }
    
    var presentsLoginView: Bool {
        loginContext == nil
    }
}
