import SwiftUI
/// Viewの拡張
extension View {
    /// ナビゲーションバーの設定
    /// - note: タイトルを.navigationTitleで指定すると、端末設定で文字サイズが拡大してしまうため、ToolBarItemを用いてフォントサイズを指定
    @ViewBuilder
    func toolBar(
        title: String,
        onTapLeftButton: (() -> Void)? = nil,
        onTapRightButton: (() -> Void)? = nil,
    ) -> some View {
        self.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    onTapLeftButton?()
                } label: {
                    Image(systemName: "arrow.left")
                }
            }
            ToolbarItem(placement: .title) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onTapRightButton?()
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
        }
    }
    /// カスタムダイアログ表示
    @ViewBuilder
    func dialog<Content: View, Background: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder background: @escaping () -> Background
    ) -> some View {
        self.modifier(
            DialogModifier(
                isPresented: isPresented,
                dialogcontent: content,
                background: background
            )
        )
    }
    /// カスタムローディング表示
    @ViewBuilder
    func loading<Background: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder background: @escaping () -> Background
    ) -> some View {
        self.modifier(
            LoadingModifier(
                isPresented: isPresented,
                background: background
            )
        )
    }
    /// ボトムシート表示
    @ViewBuilder
    func floatingBottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> () = {},
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(
            isPresented: isPresented,
            onDismiss: onDismiss
        ) {
            content()
                .presentationCornerRadius(16)
                .presentationDragIndicator(.hidden)
                .presentationBackgroundInteraction(.disabled)
                .interactiveDismissDisabled(true)
        }
    }
    /// アラート表示(OKボタン)
    func alert(
        isPresented: Binding<Bool>,
        message: String,
        errorCode: String,
        onTapOKButton: @escaping () -> Void
    ) -> some View {
        self.alert(.init(stringLiteral: .init()), isPresented: isPresented) {
            Button("OK") {
                onTapOKButton()
            }
        } message: {
            Text("\(message)\n\(errorCode)")
        }
    }
}

