import SwiftUI

struct RootView: View {
    @State var state: RootViewState
    
    var body: some View {
        // RouterのpathをNavigationStack にバインド
        NavigationStack(path: $state.router.path) {
            LoginView(
                viewState: .init(
                    router: state.router,
                    loginStore: state.loginStore
                )
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .main:
                    MainView(
                        viewState: .init(
                            router: state.router,
                            loginStore: state.loginStore
                        )
                    ) // MainView に遷移
                case .detail:
                    DetailView(
                        viewState: .init(
                            router: state.router,
                            loginStore: state.loginStore
                        )
                    ) // DetailViewに遷移
                }
            }
        }
    }
}

//#Preview {
//    RootView()
//}
