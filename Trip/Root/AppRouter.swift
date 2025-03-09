import SwiftUI
/// 画面遷移を管理するRouter
@MainActor @Observable
final class AppRouter {
    var path: NavigationPath = .init() // NavigationStackの履歴管理
    /// pudh遷移
    func push(_ route: AppRoute) {
        path.append(route)
    }
    /// pop遷移
    func pop() {
        path.removeLast()
    }
    /// ルートに戻る
    func popToRoot() {
        path = .init()
    }
}
/// 画面遷移のルート定義
enum AppRoute: Hashable {
    case main
    case detail
}
