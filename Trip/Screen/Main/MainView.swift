import SwiftUI

struct MainView: View {
    
    @State var state: MainViewState
    @Environment(\.alert) var alert
    
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
        .onChange(of: state.isShowAlert) { _, newValue in
            if newValue {
                alert.show(state.alertContent)
            } else {
                alert.hide()
            }
        }
        .task {
            print("task: \(Thread.unsafeCurrent)")
            let myObject = SampleObject()
            myObject.run()
            await myObject.runAsync()
            await myObject.runAsyncConcurrent()
            myObject.runNonisolated()
            await myObject.runNonisolatedAsync()
            await myObject.runNonisolatedAsyncConcurrent()
        }
    }
}

#Preview {
    let router: AppRouter = .init()
    let state: MainViewState = .init(router: router)
    MainView(state: state)
}

