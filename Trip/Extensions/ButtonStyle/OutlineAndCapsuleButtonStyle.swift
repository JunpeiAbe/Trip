import SwiftUI
/// ボタンスタイル共通定義
/// 背景は白、文字色とボーダー色を指定可能
struct OutlineAndCapsuleButtonStyle: ButtonStyle {
    var textColor: Color = .white
    var borderColor: Color = .white
    var backgroundColor: Color = .blue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor)
            .font(.system(size: 18, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: .infinity, style: .circular)
                    .stroke(borderColor, lineWidth: 8)
            )
            .clipShape(.capsule)
            .brightness(configuration.isPressed ? -0.1 : 0.0)
            .shadow(color: .init(.gray), radius: 8, x: 4, y: 4)
    }
}

#Preview {
    Button("outlineAndCapsule") {
        
    }
    .buttonStyle(.outlineAndCapsule())
    .frame(height: 48)
    .padding()
}
