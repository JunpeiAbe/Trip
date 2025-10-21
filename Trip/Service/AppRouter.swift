import SwiftUI
/// 画面遷移を管理
@MainActor @Observable
final class AppRouter {
    var path: [AppRoute] = [] // NavigationStackの履歴管理
    /// pudh遷移
    func push(_ route: AppRoute) {
        path.append(route)
    }
    /// pop遷移
    func pop() {
        path.removeLast()
    }
    /// pop遷移(特定画面まで戻る)
    func pop(_ route: AppRoute) {
        while !path.isEmpty || path.last != route {
            path.removeLast()
        }
    }
    /// ルートに戻る
    func popToRoot() {
        path.removeAll()
    }
}
/// 画面遷移のルート定義
enum AppRoute: Hashable {
    case login
    case main
    case detail
}
