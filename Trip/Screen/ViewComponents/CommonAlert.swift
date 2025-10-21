import SwiftUI
/// 共通ダイアログ
// 参考: https://www.youtube.com/watch?v=Fa_d661SBrA&t=302s
struct CommonDialog: View {
    var title: String
    var message: String?
    var iconImage: IconConfiguration
    var primaryButton: ButtonConfiguration
    var secondaryButton: ButtonConfiguration?
    var includesTextField: Bool = false
    var textFieldPlaceholder: String = ""
    /// State Properties
    @State private var text: String = ""
    var body: some View {
        VStack(spacing: 15) {
            iconImage(iconImage)
            Text(title)
                .font(.title3.bold())
            if let message {
                Text(message)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundStyle(.gray)
                    .padding(.vertical, 4)
            }
            if includesTextField {
                TextField(textFieldPlaceholder, text: $text)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.1))
                    }
                    .padding(.bottom, 5)
            }
            
            dialogButton(primaryButton)
            
            if let secondaryButton {
                dialogButton(secondaryButton)
            }
        }
        .padding([.horizontal, .bottom], 15)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
                .padding(.top, 30)
        }
        .frame(maxWidth: 310)
        .compositingGroup()
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
    private func dialogButton(_ config: ButtonConfiguration) -> some View {
        Button {
            config.action()
        } label: {
            Text(config.title)
                .fontWeight(.bold)
                .foregroundStyle(config.foreground)
                .padding(.vertical, 10)
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

extension View {
    /// アラート表示
    /// - Parameters:
    ///   - isPresented: アラート表示の制御フラグ（バインディング）
    ///   - content: アラートの本体ビュー（例：CommonDialogなど）
    ///   - background: 背景ビュー（例：半透明グレー背景）
    /// - Returns: 任意のView
    /// - note: 任意のViewに対して以下を呼ぶことで共通化されたアラートを表示可能
    @ViewBuilder
    func alert<Content: View, Background: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder background: @escaping () -> Background
    ) -> some View {
        self
            .modifier(CommonAlertModifier(isPresented: isPresented, alertContent: content, background: background))
    }
}

/// ViewModifierとしてアラートの表示・非表示制御、アニメーション、ユーザー操作可否をまとめる
fileprivate struct CommonAlertModifier<AlertContent: View, Background: View>: ViewModifier {
    @Binding var isPresented: Bool
    let alertContent: () -> AlertContent
    let background: () -> Background
    @State private var alertState: AlertDisplayState = .init()
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $alertState.isFullScreenPresented) {
                ZStack {
                    if alertState.isAlertVisible {
                        alertContent()
                            .allowsHitTesting(alertState.isInteractionEnabled)
                    }
                }
                .presentationBackground {
                    background()
                        .opacity(alertState.isAlertVisible ? 1 : 0)
                }
                .task {
                    // アニメーションとタップの有効化
                    try? await Task.sleep(for: .seconds(0.05))
                    withAnimation(.easeInOut(duration: 0.3)) {
                        alertState.isAlertVisible = true
                    }
                    try? await Task.sleep(for: .seconds(0.3))
                    alertState.isInteractionEnabled = true
                }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                // 表示・非表示の切り替え監視
                // isPresentedがtrueになればアニメーションなしでisFullScreenCoverActive = true
                // falseになればallowsInteraction = false, アニメーションで非表示 → 完了後にisFullScreenCoverActive = false
                // Transaction: アニメーションの制御に使用する
                // アラート処理ではfullScreenCoverの表示そのものにはアニメーションをかけずに即時表示
                // その後に行うalertContentのフェードインや背景のアニメーションに対してだけ意図的にアニメーションをかけるためにTransactionを使用する
                var transaction = Transaction()
                transaction.disablesAnimations = true
                if newValue {
                    withTransaction(transaction) {
                        alertState.isFullScreenPresented = true
                    }
                } else {
                    alertState.isInteractionEnabled = false
                    withAnimation(.easeInOut(duration: 0.3), completionCriteria: .removed) {
                        alertState.isAlertVisible = false
                    } completion: {
                        withTransaction(transaction) {
                            alertState.isFullScreenPresented = false
                        }
                    }
                }
            }
    }
    private struct AlertDisplayState {
        /// .fullScreenCover表示するかどうか
        var isFullScreenPresented: Bool = false
        /// アラートが表示中かどうか（trueなら表示中）
        var isAlertVisible: Bool = false
        /// タップなどの操作が可能か(完全に表示された後に操作を有効化する)
        var isInteractionEnabled: Bool = false
    }
}

struct CommonAlertSampleView: View {
    @State private var showAlert = false
    var body: some View {
        NavigationStack {
            List {
                Button("Show Alert") {
                    showAlert.toggle()
                }
                .alert(isPresented: $showAlert) {
                    CommonDialog(
                        title: "ダイアログのタイトル",
                        message: "メッセージ",
                        iconImage: .init(systemName: "folder.fill.badge.plus", background: .blue, foreground: .white),
                        primaryButton: .init(title: "Primary", background: .red, foreground: .white) {
                            showAlert = false
                        },
                        secondaryButton: .init(title: "Secondary", background: .red, foreground: .white) {
                            showAlert = false
                        },
                        includesTextField: false,
                        textFieldPlaceholder: "Personal Documents"
                    )
                } background: {
                    Rectangle()
                        .fill(.primary.opacity(0.20))
                }
            }
            .navigationTitle("Common Alert")
        }
    }
}

#Preview {
    CommonAlertSampleView()
}
