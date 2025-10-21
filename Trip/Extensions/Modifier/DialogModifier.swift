import SwiftUI
/// カスタムダイアログ表示modifier
/// - note: アニメーションを無効化できないケースがあるため、実装検討が必要
struct DialogModifier<DialogContent: View, Background: View>: ViewModifier {
    @Binding var isPresented: Bool
    @State var showFullScreenCover: Bool = false
    let dialogcontent: () -> DialogContent
    let background: () -> Background
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $showFullScreenCover) {
                dialogcontent()
                    .presentationBackground {
                        background()
                    }
            }
            .onChange(of: isPresented) { _, newValue in
                ///  - note:Transaction は「SwiftUI が 1回の状態変化に伴って行う描画処理 を管理する設定パッケージ。fullScreenCoverのアニメーションを伴う描画処理におけるアニメーションのみを無効化している
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    showFullScreenCover = newValue
                }
            }
    }
}
