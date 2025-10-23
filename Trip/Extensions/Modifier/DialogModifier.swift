import SwiftUI
/// カスタムダイアログ表示modifier
/// - note: アニメーションを無効化できないケースがあるため、実装検討が必要
struct DialogModifier<DialogContent: View, Background: View>: ViewModifier {
    @Binding var isPresented: Bool
    let dialogcontent: () -> DialogContent
    let background: () -> Background
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    ZStack {
                        background()
                            .ignoresSafeArea()
                        dialogcontent()
                    }
                }
            }
    }
}
