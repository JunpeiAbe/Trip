import Foundation
/// 入力欄のバリデーションプロトコル
@MainActor
protocol TextFieldValidatable {
    // フォーカスアウト時の入力チェック
    func checkTextOnFocusOut(_ text: String, pattern: String, focusedField: FocusableField) -> Bool
    // 入力中の文字種チェック
    func checkTextOnChange(_ text: String, focusedField: FocusableField)
    // 正規表現で文字列がマッチするかチェック
    func matchesRegex(_ text: String, pattern: String) -> Bool
    // 許可された文字のみをフィルタリングする
    func filterAllowedCharacters(from text: String, allowedPattern: String) -> String
}

extension TextFieldValidatable {
    // 正規表現で文字列がマッチするかチェック
    func matchesRegex(_ text: String, pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(location: 0, length: text.count)
        return regex.firstMatch(in: text, range: range) != nil
    }
    // 許可された文字のみをフィルタリングする
    func filterAllowedCharacters(from text: String, allowedPattern: String) -> String {
        // NSRegularExpressionを作成し、allowedPattern（許可する文字の正規表現）を設定。
        guard let regex = try? NSRegularExpression(pattern: allowedPattern) else { return "" }
        // text.filter {}を使って、文字列を1文字ずつ評価
        // String(char)で文字(Character)をStringに変換。（NSRegularExpressionはStringしか扱えないため）
        // NSRange(location: 0, length: charAsString.count)で文字の範囲を指定
        // regex.firstMatch(in: charAsString, options: [], range: range)で、文字が正規表現にマッチするか確認
        // マッチした文字のみを新しい文字列として返す
        return text.filter { char in
            let charAsString = String(char)
            let range = NSRange(location: 0, length: charAsString.count)
            return regex.firstMatch(in: charAsString, range: range) != nil
        }
    }
}
