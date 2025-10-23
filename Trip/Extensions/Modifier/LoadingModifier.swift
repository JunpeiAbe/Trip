import SwiftUI
/// ローディング表示modifier
/// - note: 子のViewではnavigation bar上に重ねて表示できないため、NavigationStack直下で使用する
struct LoadingModifier<Background: View>: ViewModifier {
    @Binding var isPresented: Bool
    let background: () -> Background
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    ZStack {
                        background()
                            .ignoresSafeArea()
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.white)
                            .shadow(radius: 8, x: 4, y: 4)
                        ProgressView()
                            .scaleEffect(2.0)
                    }
                }
            }
    }
}
