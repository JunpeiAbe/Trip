import SwiftUI
/// ボタンスタイル共通定義
/// 背景色あり、文字色は白
struct FilledButtonStyle: ButtonStyle {
    var backgroundColor: Color = .blue
    var cornerRadius: CGFloat = 8
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .shadow(color: .init(.systemGray4), radius: 8, y: 4)
            .brightness(configuration.isPressed ? -0.1 : 0.0)
    }
}

#Preview {
    Button("filled") {
        
    }
    .buttonStyle(.filled())
    .frame(height: 40)
    .padding()
}
