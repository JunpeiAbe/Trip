import SwiftUI

struct DetailView: View {
    
    @State var state: DetailViewState
    // 3列グリッド
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        HStack(alignment: .center) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(0..<1000) { _ in
                        ThumnailView()
                    }
                }
            }
        }
        .navigationTitle("Collection")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    let router: AppRouter = .init()
    let repository: AuthRepository = .init()
    let loginStore: LoginStore = .init(authRepository: repository)
    let state: DetailViewState = .init(router: router, loginStore: loginStore)
    DetailView(state: state)
}
