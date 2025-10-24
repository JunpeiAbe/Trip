import Foundation
/// Dateの拡張
extension Date {
    /// 指定したフォーマットで文字列に変換（日本ロケール固定）
    func formatted(_ style: DateFormatStyle) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = style.formatString
        return formatter.string(from: self)
    }
}

/// よく使う日付フォーマットの列挙
enum DateFormatStyle {
    case yyyyMMdd
    case yyyyMMddWithSlash
    case yyyyMMddHHmm
    case yyyyMMddHHmmss
    case custom(String)
    
    var formatString: String {
        switch self {
        case .yyyyMMdd:
            return "yyyy-MM-dd"
        case .yyyyMMddWithSlash:
            return "yyyy/MM/dd"
        case .yyyyMMddHHmm:
            return "yyyy-MM-dd HH:mm"
        case .yyyyMMddHHmmss:
            return "yyyy-MM-dd HH:mm:ss"
        case .custom(let format):
            return format
        }
    }
}
