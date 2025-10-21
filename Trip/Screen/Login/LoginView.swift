import SwiftUI

struct LoginView: View {
    
    @State var viewState: LoginViewState
    // どの入力欄にフォーカスが当たっているか
    @FocusState private var focusedField: FocusableField?
    
    var body: some View {
        
        ZStack {
            // 背景をタップするとフォーカスを解除
            Color.clear
                .contentShape(Rectangle()) // タップ判定を有効にする
                .onTapGesture {
                    focusedField = nil
                }
            VStack(spacing: 8) {
                CommonTextField(
                    text: $viewState.email,
                    placeHolder: "email",
                    onSubmit: { text in
                        viewState.emailTextDidChange(text)
                        viewState.checkTextOnFocusOut(text, pattern: AllowedCharacterRegex.emailSymbols.pattern, focusedField: .email)
                    },
                    onChanged: { text in
                        viewState.checkTextOnChange(text, focusedField: .email)
                    }
                )
                .focused($focusedField, equals: .email) // 入力欄タップ時にfocusedFieldの値を更新する
                /// パスワード入力欄
                CommonTextField(
                    text: $viewState.password,
                    placeHolder: "password",
                    onSubmit: { text in
                        viewState.passwordTextDidChange(text)
                        viewState.checkTextOnFocusOut(text, pattern: AllowedCharacterRegex.passwordSymbols.pattern, focusedField: .password)
                    },
                    onChanged: { text in
                        viewState.checkTextOnChange(text, focusedField: .password)
                    }
                )
                .focused($focusedField, equals: .password) // 入力欄タップ時にfocusedFieldの値を更新する
                /// ログインボタン
                CommonButton(
                    title: "Login",
                    isEnabled: .constant(viewState.isLoginButtonEnabled)
                ) {
                    viewState.loginButtonPressed()
                }
                .frame(height: 48)
            }
            .padding(.horizontal, 16)
            
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewState.focusingField) { oldField, newField in
            // viewStateのfocusingFieldを更新時にViewのfocusedFieldを更新
            // viewState→viewへの反映
            focusedField = newField
            if newField == nil,
               oldField == FocusableField.email {
                viewState.checkTextOnFocusOut(viewState.email, pattern: AllowedCharacterRegex.emailSymbols.pattern, focusedField: .email)
            }
            
            if newField == nil,
               oldField == FocusableField.password {
                viewState.checkTextOnFocusOut(viewState.password, pattern: AllowedCharacterRegex.passwordSymbols.pattern, focusedField: .password)
            }
        }
        .onChange(of: focusedField) { _, newValue in
            // focusedFieldが変わったらviewState.focusingFieldに反映
            // view→viewStateへの反映
            viewState.onFocusedFieldChanged(focusedField: newValue)
        }
    }
}
