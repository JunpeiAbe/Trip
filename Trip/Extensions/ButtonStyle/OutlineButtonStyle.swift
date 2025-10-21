import SwiftUI
/// ボタンスタイル共通定義
/// 背景は白、文字色とボーダー色を指定可能
struct OutlinedButtonStyle: ButtonStyle {
    var textColor: Color = .white
    var borderColor: Color = .white
    var backgroundColor: Color = .blue
    var cornerRadius: CGFloat = 8
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor)
            .font(.system(size: 18, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 8)
            )
            .clipShape(.rect(cornerRadius: cornerRadius))
            .brightness(configuration.isPressed ? -0.1 : 0.0)
            .shadow(color: .init(.gray), radius: 8, y: 4)
            
    }
}

#Preview {
    Button("outlined") {
        
    }
    .buttonStyle(.outlineAndCapsule())
    .frame(height: 48)
    .padding()
}
