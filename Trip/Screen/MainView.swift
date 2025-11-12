import SwiftUI

struct MainView: View {
    
    @State var state: MainViewState
    
    var body: some View {
        VStack(alignment: .center) {
            /// アラート表示ボタン
            Button("Show Error Alert") {
                state.showErrorAlertButtonPressed()
            }
            .frame(height: 48)
            .buttonStyle(.filled())
            /// アラート表示ボタン
            Button("Show Confirm Alert") {
                state.showConfirmAlertButtonPressed()
            }
            .frame(height: 48)
            .buttonStyle(.filled())
            /// 詳細画面遷移ボタン
            Button("Detail") {
                state.detailButtonPressed()
            }
            .frame(height: 48)
            .buttonStyle(.filled())
        }
        .padding(.horizontal, 16)
        .navigationTitle("Main")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            state.onAppear()
        }
        .alert(
            state.alertContent.title,
            isPresented: .constant(state.isShowAlert)) {
                Button("キャンセル") {
                    state.alertContent.onTapCancelButton()
                }
                Button("OK") {
                    state.alertContent.onTapOKButton()
                }
            } message: {
                Text(state.alertContent.message)
            }
    }
}

#Preview {
    let router: AppRouter = .init()
    let state: MainViewState = .init(router: router)
    MainView(state: state)
}

