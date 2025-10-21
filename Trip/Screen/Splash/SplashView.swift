import SwiftUI
/// スプラッシュ画面
struct SplashView: View {
    
    @State var state: SplashViewState
    
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: .tripIcon)
                .resizable()
                .frame(width: 96, height: 96)
        }
        .task {
            state.firstLoad()
        }
    }
}
