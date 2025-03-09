import SwiftUI

struct RootView: View {
    @State private var state: RootViewState = .init()
    
    var body: some View {
        NavigationStack(path: $state.router.path) { // ✅ Router の path を NavigationStack にバインド
            LoginView(viewState: .init(router: state.router)) // ✅ 初期画面
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .main:
                        MainView(viewState: .init(router: state.router)) // MainView に遷移
                    case .detail:
                        DetailView(viewState: .init(router: state.router)) // DetailViewに遷移
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
