import SwiftUI
/// 画面遷移を管理するRouter
@MainActor @Observable
final class AppRouter {
    var path: NavigationPath = .init() // NavigationStackの履歴管理
    var routeStack: [AppRoute] = []
    /// pudh遷移
    func push(_ route: AppRoute) {
        path.append(route)
        routeStack.append(route)
    }
    /// pop遷移
    func pop() {
        guard !routeStack.isEmpty else { return }
        path.removeLast()
        routeStack.removeLast()
    }
    /// pop遷移(特定画面まで戻る)
    func pop(_ route: AppRoute) {
        while !routeStack.isEmpty {
            // 指定画面とrouteStackの最後の履歴が一致した場合、
            if routeStack.last == route {
                break
            }
            path.removeLast()
            routeStack.removeLast()
        }
    }
    /// ルートに戻る
    func popToRoot() {
        path = .init()
        routeStack.removeAll()
    }
}
/// 画面遷移のルート定義
enum AppRoute: Hashable {
    case login
    case main
    case detail
}
