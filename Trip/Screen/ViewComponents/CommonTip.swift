import Foundation
import TipKit
/// ツールチップへの表示内容
struct TipContent: Tip {
    var title: Text {
        Text("title")
    }
    
    var message: Text? {
        Text("message")
    }
    
    var image: Image? {
        Image(.thumnail)
    }
    
    var options: TipOption {
        Self.IgnoresDisplayFrequency(true)
    }
}

struct TipContentView: View {
    private var tipContent = TipContent()
    
    var body: some View {
        VStack {
            TipView(tipContent)
            Spacer()
            Button("show ToolTip") {
               
            }
            .frame(height: 48)
            .popoverTip(tipContent)
        }
        .padding()
    }
}

#Preview {
    TipContentView()
}
