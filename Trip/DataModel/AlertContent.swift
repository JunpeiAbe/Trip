import Foundation

struct AlertContent {
    var title: String
    var message: String
    var errorCode: String
    var onTapOKButton: @Sendable () -> Void
}
