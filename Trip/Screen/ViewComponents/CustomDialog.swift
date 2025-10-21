import SwiftUI
/// 画面全体に可能な限り、大きく表示するダイアログ
struct CustomDialog: View {
    /// 閉じるボタンタップ時
    var onClose: (() -> Void)?
    
    var body: some View {
        dialogSheet
    }
    
    @ViewBuilder
    var dialogSheet: some View {
        VStack(spacing: .zero) {
            ScrollView {
                sampleContent
            }
            .contentMargins(.all, 16, for: .scrollContent)
            Button("閉じる"){
                onClose?()
            }
            .buttonStyle(.outlineAndCapsule())
            .frame(width: 200, height: 48)
            .padding(16)
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .shadow(radius: 4, x: 4, y: 4)
        }
        .padding(.horizontal, 16)
        .padding([.top, .bottom], 32)
    }
}

@ViewBuilder
var sampleContent: some View {
    VStack {
        Text(String(repeating: "サンプル", count: 1000))
            .font(.system(size: 12))
    }
}

#Preview {
    CustomDialog()
}

