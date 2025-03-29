import SwiftUI

@main
struct TripApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                state: .init(
                    router: AppRouter(),
                    loginStore: .init(
                        authRepository: StubAuthRepository_Success()
                    )
                )
            )
        }
    }
}
