import SwiftUI
/// 共通入力欄
struct CommonTextField: View {
    
    @Binding var text: String
    var placeHolder: String = ""
    //var isError: Bool = false
    //var changeBorderColorOnFocus: Bool = false
    let onSubmit: (String) -> Void
    let onChanged: (String) -> Void
    
//    var borderColor: Color {
//        if isError {
//            return .red
//        } else if changeBorderColorOnFocus {
//            return .green
//        } else {
//            return .gray
//        }
//    }
    
    var body: some View {
        TextField(
            placeHolder,
            text: $text,
            axis: .horizontal
        )
        .textFieldStyle(.roundedBorder)
        //.textFieldStyle(.plain)
//        .overlay( // ✅ ボーダーを `overlay` でカスタマイズ
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(borderColor, lineWidth: 2)
//        )
        .onSubmit {
            onSubmit(text)
        }
        .onChange(of: text) { _, newValue in
            onChanged(newValue)
        }
    }
}


