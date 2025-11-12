import Foundation
/// アラートの表示状態
enum AlertState: Equatable {
    case dismissed
    case presenting(AlertType)
    
    var alertType: AlertType? {
        switch self {
        case .dismissed:
            return nil
        case .presenting(let alertType):
            return alertType
        }
    }
}

