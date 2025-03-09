import SwiftUI
/// 共通ボタン
// メンバーワイズイニシャライザでプロパティを指定
struct CommonButton: View {
    
    var title: String
    var font: Font = .system(size: 16, weight: .regular)
    var foregroundColor: Color = .white
    var nomalBackgroundColor: Color = .blue
    var disabledBackgroundColor: Color = .gray
    var cornerRadius: CGFloat = 0
    @Binding private(set) var isEnabled: Bool
    let pressed: () -> Void
    
    var body: some View {
        Button(action: pressed) {
            Label(
                title: {
                    Text(title)
                        .font(font)
                },
                icon: {
                    
                }
            )
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .foregroundStyle(foregroundColor)
            .background(
                isEnabled
                ? nomalBackgroundColor
                : disabledBackgroundColor
            )
            .clipShape(
                RoundedRectangle(cornerRadius: cornerRadius)
            )
        }
        .disabled(!isEnabled)
    }
}

#Preview {
    CommonButton(
        title: "Common",
        isEnabled: .constant(true)
    ) {
        print("Pressed")
    }
    .frame(width: .infinity, height: 60)
}
