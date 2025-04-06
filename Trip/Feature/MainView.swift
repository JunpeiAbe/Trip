import SwiftUI

struct MainView: View {
    
    @State var viewState: MainViewState
    
    var body: some View {
        HStack(alignment: .center) {
            /// ログアウトボタン
            CommonButton(
                title: "Logout",
                isEnabled: .constant(true)
            ) {
                viewState.logOutButtonPressed()
            }
            .frame(height: 48)
            /// ログアウトボタン
            CommonButton(
                title: "Detail",
                isEnabled: .constant(true)
            ) {
                viewState.detailButtonPressed()
            }
            .frame(height: 48)
        }
        .padding(.horizontal, 16)
        .navigationTitle("Main")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

