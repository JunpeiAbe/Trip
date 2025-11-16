import Foundation
/// アラートの表示内容
struct AlertContent: Equatable {
    /// タイトル
    var title: String
    /// メッセージ
    var message: String
    /// エラーコード
    var errorCode: String?
    /// キャンセルボタンタップ
    var onTapCancelButton: () -> Void?
    /// OKボタンタップ
    var onTapOKButton: () -> Void?

    static func == (lhs: AlertContent, rhs: AlertContent) -> Bool {
        lhs.title == rhs.title &&
        lhs.message == rhs.message &&
        lhs.errorCode == rhs.errorCode
        // Note: Closures are intentionally not compared.
    }
}
