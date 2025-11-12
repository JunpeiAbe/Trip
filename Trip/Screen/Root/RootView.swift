import SwiftUI

struct RootView: View {
    @State var state: RootViewState
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        // RouterのpathをNavigationStack にバインド
        NavigationStack(path: $state.router.path) {
            SplashView(
                state: .init(
                    router: state.router,
                    loginStore: state.loginStore
                )
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .login:
                    LoginView(
                        viewState: .init(
                            router: state.router,
                            loginStore: state.loginStore
                        )
                    ) // LoginView に遷移
                case .main:
                    MainView(
                        state: .init(
                            router: state.router
                        )
                    ) // MainView に遷移
                case .detail:
                    DetailView(
                        state: .init(
                            router: state.router,
                            loginStore: state.loginStore
                        )
                    ) // DetailViewに遷移
                    
                }
            }
        }
        .overlay {
            Color.overlayGray
                .ignoresSafeArea()
                .alert(
                    isPresented: .constant(state.isShowAlert),
                    message: state.alertContent?.message ?? .init(),
                    errorCode: state.alertContent?.errorCode ?? .init(),
                    onTapOKButton: {
                        print("onTapOKButton")
                        state.alertContent?.onTapOKButton()
                        state.alertContent = nil
                    }
                )
        }
        .loading(
            isPresented: $state.isLoading,
            background: { Color.overlayGray }
        )
        .dialog(
            isPresented: $state.isShowDialog,
            content: {
                CustomDialog(isChecked: $state.isDialogChecked)
            },
            background: { Color.overlayGray }
        )
        .environment(
            \.loading,
             .init(
                show: { state.isLoading = true },
                hide: { state.isLoading = false }
             )
        )
        .environment(
            \.dialog,
             .init(
                show: { state.isShowDialog = true },
                hide: { state.isShowDialog = false },
                onCheck: { state.isDialogChecked.toggle() },
                onClose: { state.onTapDialogCloseButton() }
             )
        )
        .onChange(of: scenePhase, initial: false) { old, new in
            switch scenePhase {
            case .background:
                state.onBackground()
            case .active:
                state.onForeground()
            case .inactive:
                break
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    let router: AppRouter = .init()
    let repository: AuthRepository = .init()
    let loginStore: LoginStore = .init(authRepository: repository)
    let state: RootViewState = .init(router: router, loginStore: loginStore)
    RootView(state: state)
}
