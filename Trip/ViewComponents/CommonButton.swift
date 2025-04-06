import SwiftUI
/// 共通ボタン
// メンバーワイズイニシャライザでプロパティを指定
struct CommonButton: View {
    
    enum IconPosition {
        case top, leading, trailing, bottom
    }
    
    struct Style {
        var font: Font = .system(size: 16, weight: .bold)
        var foregroundColor: Color = .white
        var normalBackgroundColor: Color = .blue
        var disabledBackgroundColor: Color = .gray
        var cornerRadius: CGFloat = 8
        var iconColor: Color = .white
        var iconSpacing: CGFloat = 8
        var iconSize: CGFloat = 24
    }
    
    var title: String
    var icon: Image?
    var iconPosition: IconPosition = .leading
    var style: Style = .init()
    @Binding var isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            content
            .font(style.font)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(style.foregroundColor)
            .background(
                isEnabled
                ? style.normalBackgroundColor
                : style.disabledBackgroundColor
            )
            .clipShape(
                RoundedRectangle(cornerRadius: style.cornerRadius)
            )
        }
        .disabled(!isEnabled)
    }
    
    @ViewBuilder
    private var content: some View {
        if icon != nil {
            VStack(spacing: style.iconSpacing) {
                if iconPosition == .top {
                    iconImage
                        .foregroundStyle(style.iconColor)
                }
                HStack(spacing: style.iconSpacing) {
                    if iconPosition == .leading {
                        iconImage
                            .foregroundStyle(style.iconColor)
                    }
                    Text(title)
                    if iconPosition == .trailing {
                        iconImage
                            .foregroundStyle(style.iconColor)
                    }
                }
                if iconPosition == .bottom {
                    iconImage
                        .foregroundStyle(style.iconColor)
                }
            }
        } else {
            Text(title)
        }
    }
    
    @ViewBuilder
    private var iconImage: some View {
        icon?
            .resizable()
            .scaledToFit()
            .foregroundStyle(style.iconColor)
            .frame(width: style.iconSize, height: style.iconSize)
    }
}

extension CommonButton {
        
        /// ① 文字のみ（背景あり）
        static func textOnly(
            title: String,
            style: CommonButton.Style = .init(),
            isEnabled: Binding<Bool>,
            action: @escaping () -> Void
        ) -> some View {
            CommonButton(
                title: title,
                icon: nil,
                iconPosition: .leading,
                style: style,
                isEnabled: isEnabled,
                action: action
            )
        }

        /// ② アイコンのみ（背景なし）※CommonButtonベース
        static func iconOnly(
            icon: Image,
            iconColor: Color = .blue,
            iconSize: CGFloat = 24,
            isEnabled: Binding<Bool> = .constant(true),
            action: @escaping () -> Void
        ) -> some View {
            let style = CommonButton.Style(
                font: .body,
                foregroundColor: iconColor,
                normalBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                cornerRadius: 0,
                iconColor: iconColor,
                iconSpacing: 0
            )

            return CommonButton(
                title: .init(),
                icon: icon,
                iconPosition: .leading,
                style: style,
                isEnabled: isEnabled,
                action: action
            )
            .frame(width: iconSize, height: iconSize)
        }

        /// ③ アイコン＋背景（背景あり・テキストなし）
        static func iconWithBackground(
            icon: Image,
            backgroundColor: Color = .blue,
            iconColor: Color = .white,
            cornerRadius: CGFloat = 8,
            isEnabled: Binding<Bool> = .constant(true),
            action: @escaping () -> Void
        ) -> some View {
            let style = CommonButton.Style(
                font: .body,
                foregroundColor: iconColor,
                normalBackgroundColor: backgroundColor,
                disabledBackgroundColor: backgroundColor.opacity(0.3),
                cornerRadius: cornerRadius,
                iconColor: iconColor,
                iconSpacing: 0
            )

            return CommonButton(
                title: "",
                icon: icon,
                iconPosition: .leading,
                style: style,
                isEnabled: isEnabled,
                action: action
            )
        }

        /// ④ テキスト＋アイコン（位置指定）
        static func textWithIcon(
            title: String,
            icon: Image,
            iconPosition: CommonButton.IconPosition = .leading,
            style: CommonButton.Style = .init(),
            isEnabled: Binding<Bool>,
            action: @escaping () -> Void
        ) -> some View {
            CommonButton(
                title: title,
                icon: icon,
                iconPosition: iconPosition,
                style: style,
                isEnabled: isEnabled,
                action: action
            )
        }
    }

#Preview {
    VStack(spacing: 20) {
            
            // ① 文字のみ
            CommonButton.textOnly(
                title: "ログイン",
                isEnabled: .constant(true),
                action: { print("ログイン") }
            )
            .frame(height: 50)
            
            // ② アイコンのみ（背景なし）
            CommonButton.iconOnly(
                icon: Image(systemName: "heart.fill"),
                iconColor: .green,
                iconSize: 32,
                action: { print("ハート押下") }
            )

            // ③ アイコン＋背景
            CommonButton.iconWithBackground(
                icon: Image(systemName: "pencil"),
                backgroundColor: .orange,
                action: { print("編集ボタン") }
            )
            .frame(width: 44, height: 44)

            // ④ 文字＋アイコン（右）
            CommonButton.textWithIcon(
                title: "次へ",
                icon: Image(systemName: "chevron.right"),
                iconPosition: .trailing,
                isEnabled: .constant(true),
                action: { print("次へ押下") }
            )
            .frame(height: 50)
            
        }
        .padding()
}
