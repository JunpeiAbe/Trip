import SwiftUI

struct DetailView: View {
    
    @State var viewState: DetailViewState
    
    var body: some View {
        HStack(alignment: .center) {
            /// ログアウトボタン
            CommonButton(
                title: "Logout",
                cornerRadius: 8,
                isEnabled: .constant(true)
            ) {
                viewState.logOutButtonPressed()
            }
            .frame(height: 48)
        }
        .padding(.horizontal, 16)
        .navigationTitle("Detail")
    }
}
