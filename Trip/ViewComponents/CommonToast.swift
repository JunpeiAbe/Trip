import SwiftUI

extension View {
    @ViewBuilder
    func interactiveToasts(_ toasts: Binding<[CommonToast]>) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                ToastsView(toasts: toasts)
            }
    }
}

struct CommonToast: Identifiable {
    private(set) var id: String = UUID().uuidString
    var content: AnyView
    
    init(@ViewBuilder content: @escaping (String) -> some View) {
        self.content = .init(content(id))
    }
}

struct ToastsView: View {
    @Binding var toasts: [CommonToast]
    @State private var isExpanded: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            if isExpanded {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isExpanded = false
                    }
            }
            let layout = isExpanded ? AnyLayout(VStackLayout(spacing: 10)) : AnyLayout(ZStackLayout())
            layout {
                ForEach($toasts) { $toast in
                    let index = (toasts.count - 1) - (toasts.firstIndex(where: { $0.id == toast.id }) ?? 0)
                    toast.content
                        .visualEffect { [isExpanded] content, proxy in
                            content
                                .scaleEffect(isExpanded ? 1 : scale(index), anchor: .bottom)
                                .offset(y: isExpanded ? 0 : offsetY(index))
                        }
                        .transition(.asymmetric(insertion: .offset(y: 100), removal: .push(from: .top)))
                }
            }
            .onTapGesture {
                isExpanded.toggle()
            }
        }
        .animation(.bouncy, value: isExpanded)
        .padding(.bottom, 15)
    }
    
    nonisolated func offsetY(_ index: Int) -> CGFloat {
        let offSet = min(CGFloat(index) * 15, 30)
        return -offSet
    }
    
    nonisolated func scale(_ index: Int) -> CGFloat {
        let scale = min(CGFloat(index) * 0.1, 1)
        return 1 - scale
    }
}

struct CommonToastSampleView: View {
    @State private var toasts: [CommonToast] = []
    var body: some View {
        NavigationStack {
            List {
                Text("Dummy")
            }
            .navigationTitle("Toasts")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Show") {
                        showToast()
                    }
                }
            }
        }
        .interactiveToasts($toasts)
    }
    
    func showToast() {
        withAnimation(.bouncy) {
            let toast = CommonToast { id in
                ToastView(id)
            }
            toasts.append(toast)
        }
    }
    
    @ViewBuilder
    func ToastView(_ id: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "square.and.arrow.up.fill")
            Text("Hello World")
                .font(.callout)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
            }
        }
        .foregroundStyle(.primary)
        .padding(12)
        .background {
            Capsule()
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 3, x: -1, y: -3)
                .shadow(color: .black.opacity(0.06), radius: 2, x: 1, y: 3)
        }
    }
}

#Preview {
    CommonToastSampleView()
}
