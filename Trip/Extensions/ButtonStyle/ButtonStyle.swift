import SwiftUI
/// ButtonStyleの拡張
extension ButtonStyle where Self == FilledButtonStyle {
    static func filled(backgroundColor: Color = .blue, cornerRadius: CGFloat = 8) -> FilledButtonStyle {
        FilledButtonStyle(backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
}

extension ButtonStyle where Self == OutlineAndCapsuleButtonStyle {
    static func outlineAndCapsule(textColor: Color = .white, borderColor: Color = .white) -> OutlineAndCapsuleButtonStyle {
        OutlineAndCapsuleButtonStyle(textColor: textColor, borderColor: borderColor)
    }
}

extension ButtonStyle where Self == OutlinedButtonStyle {
    static func outlined(textColor: Color = .white, borderColor: Color = .white, cornerRadius: CGFloat = 8) -> OutlinedButtonStyle {
        OutlinedButtonStyle(textColor: textColor, borderColor: borderColor, cornerRadius: cornerRadius)
    }
}
