import SwiftUI

struct RootView: View {
    @State private var state: RootViewState = .init()

    var body: some View {
        NavigationStack {
            if state.presentsLoginView {
                LoginView()
            } else {
                MainView()
            }
        }
    }
}

#Preview {
    RootView()
}
