import SwiftUI
/// 共通ボトムシート
// 参考: https://www.youtube.com/watch?v=gxOqwo7bZYE
struct ViewHeightKey: PreferenceKey {
   static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        print(nextValue())
        value = nextValue()
    }
}


struct CommonBottomSheetView: View {
    var title: String
    var message: String?
    var iconImage: IconConfiguration
    var primaryButton: ButtonConfiguration
    var secondaryButton: ButtonConfiguration
    /// State Properties
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: 16) {
                sheetButton(secondaryButton)
                sheetButton(primaryButton)
            }
        }
        .padding(16)
        .overlay (
            /// - note:overlayであればコンテンツサイズ(子ビュー)を正確に取得することができる
            /// backgroundだと子ビューのサイズを取得できない
            /// 参考: https://zenn.dev/fatbobman/articles/d76b4bb65f3f68
            GeometryReader { geometry in
                Color.clear
                    .preference(key: ViewHeightKey.self, value: geometry.size.height)
                    .ignoresSafeArea()
            }
        )
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    struct IconConfiguration {
        var systemName: String
        var background: Color
        var foreground: Color
    }

    struct ButtonConfiguration {
        var title: String
        var background: Color
        var foreground: Color
        var action: () -> Void
    }
    
    @ViewBuilder
    private func sheetButton(_ config: ButtonConfiguration) -> some View {
        Button {
            config.action()
        } label: {
            Text(config.title)
                .fontWeight(.bold)
                .foregroundStyle(config.foreground)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(config.background.gradient, in: .rect(cornerRadius: 10))
        }
    }
    
    @ViewBuilder
    private func iconImage(_ config: IconConfiguration) -> some View {
        Image(systemName: config.systemName)
            .font(.title)
            .foregroundStyle(config.foreground)
            .frame(width: 65, height: 65)
            .background(config.background.gradient, in: .circle)
            .background {
                Circle().stroke(.background, lineWidth: 8)
            }
    }
}

struct CommonBottomSheetSampleView: View {
    @State private var showSheet = false
    @State private var sheetHeight: CGFloat = 0
    var body: some View {
        NavigationStack {
            VStack {
                Button("Show Sheet") {
                    showSheet.toggle()
                }
            }
            .navigationTitle("Floating Bottom Sheet")
        }
        .floatingBottomSheet(isPresented: $showSheet) {
            CommonBottomSheetView(
                title: "シートのタイトル",
                message: "メッセージ",
                iconImage: .init(systemName: "folder.fill.badge.plus", background: .blue, foreground: .white),
                primaryButton: .init(title: "Primary", background: .blue, foreground: .white) {
                    showSheet = false
                },
                secondaryButton: .init(title: "Secondary", background: .gray, foreground: .white) {
                    showSheet = false
                }
            )
            .presentationDetents([.height(sheetHeight)])
            .onPreferenceChange(ViewHeightKey.self) { newHeight in
                Task { @MainActor in
                    sheetHeight = newHeight
                }
            }
        }
    }
}

#Preview {
    CommonBottomSheetSampleView()
}
