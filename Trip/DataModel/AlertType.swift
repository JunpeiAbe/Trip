import Foundation
/// アラート種別
enum AlertType: Equatable {
    /// エラー
    case error(AlertContent)
    /// 警告
    case warning(AlertContent)
    /// 確認
    case confirm(AlertContent)
    /// 成功
    case success(AlertContent)
    
    var content: AlertContent {
        switch self {
        case .error(let content),
                .warning(let content),
                .confirm(let content),
                .success(let content):
            return content
        }
    }
}

