import SwiftUI
import SVProgressHUD

@MainActor @Observable
final class LoginViewState: TextFieldValidatable {
    /// ログインボタン連続タップ防止(非活性に変更する)
    var isLoggingIn: Bool = false
    /// フォーカスが当たっている入力欄
    private(set) var focusingField: FocusableField?
    /// メールアドレスの入力値
    var email: String = ""
    /// メールアドレスの入力エラー
    var emailError = ""
    /// パスワードの入力値
    var password: String = ""
    /// パスワードの入力エラー
    var passwordError: String = ""
    /// ログインボタンが活性かどうか
    var isLoginButtonEnabled: Bool {
        if email.isEmpty || !emailError.isEmpty ||
           password.isEmpty || !passwordError.isEmpty
           || isLoggingIn
        {
            return false
        }
        return true
    }
    let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    /// ログインボタンタップ
    func loginButtonPressed() {
        isLoggingIn = true
        SVProgressHUD.showLoading()
        Task {
            defer { isLoggingIn = false }
            do {
                try await LoginStore.shared.logIn(email: email, password: password)
                SVProgressHUD.dismissLoading()
                router.push(.main)
            } catch {
                // アクセストークンがnilの場合
                if LoginStore.shared.value == nil {
                    print(error)
                }
                isLoggingIn = false
                SVProgressHUD.dismissLoading()
            }
        }
    }
    /// 入力メールアドレスの変更
    func emailTextDidChange(_ text: String) {
        email = text
    }
    /// 入力パスワードの変更
    func passwordTextDidChange(_ text: String) {
        password = text
    }
    /// フォーカスを当てる入力欄の変更
    func onFocusedFieldChanged(focusedField: FocusableField?) {
        focusingField = focusedField
    }
    
    func checkTextOnChange(_ text: String, focusedField: FocusableField) {
        // 指定文字種と一致するもののみ返す
        switch focusedField {
        case .email:
            email = filterAllowedCharacters(from: text, allowedPattern: AllowedCharacterRegex.emailSymbols.pattern)
        case .password:
            password = filterAllowedCharacters(from: text, allowedPattern: AllowedCharacterRegex.passwordSymbols.pattern)
        }
    }
    
    @discardableResult
    func checkTextOnFocusOut(_ text: String, pattern: String, focusedField: FocusableField) -> Bool {
        // 入力文字列が空かどうか
        guard !text.isEmpty else {
            return false
        }
        // 入力文字数上限または下限を満たしているかどうか
        if text.count > AppConst.maximumCharacters
            || text.count < AppConst.minimumCharacters {
            switch focusedField {
            case .email:
                emailError = "入力文字数上限または下限を満たしていない"
            case .password:
                passwordError = "入力文字数上限または下限を満たしていない"
            }
            return false
        }
        // 正規表現を満たしているかどうか
        if !matchesRegex(text, pattern: pattern) {
            switch focusedField {
            case .email:
                emailError = "正規表現を満たしていない"
            case .password:
                passwordError = "正規表現を満たしていない"
            }
            return false
        }
        switch focusedField {
        case .email:
            emailError = ""
        case .password:
            passwordError = ""
        }
        return true
    }
}
