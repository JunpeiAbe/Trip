import SwiftUI

struct DetailView: View {
    
    @State var state: DetailViewState
    @Environment(\.loading) var loading
    
    var body: some View {
        HStack(alignment: .center) {
            Button("Show Indicator"){
                state.didTapShowIndicatorButton()
            }
            .buttonStyle(.outlineAndCapsule())
            .frame(height: 40)
            .padding(.horizontal, 16)
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(
            of: state.isShowLoading
        ) { _, newValue in
            if newValue {
                loading.show()
            } else {
                loading.hide()
            }
        }
    }
}

#Preview {
    let router: AppRouter = .init()
    let repository: AuthRepository = .init()
    let loginStore: LoginStore = .init(authRepository: repository)
    let state: DetailViewState = .init(router: router, loginStore: loginStore)
    DetailView(state: state)
}
