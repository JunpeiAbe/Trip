import Foundation

struct AlertContent: Equatable {
    var title: String
    var message: String
    var errorCode: String?
    var onTapCancelButton: () -> Void?
    var onTapOKButton: () -> Void?

    static func == (lhs: AlertContent, rhs: AlertContent) -> Bool {
        lhs.title == rhs.title &&
        lhs.message == rhs.message &&
        lhs.errorCode == rhs.errorCode
        // Note: Closures are intentionally not compared.
    }
}
