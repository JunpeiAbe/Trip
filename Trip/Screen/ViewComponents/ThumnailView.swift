import SwiftUI

struct ThumnailView: View {
    /// 端末の画面スケールを取得する(1x, 2x, 3x)
    /// 1x: 1pt = 1px, 2x: 1pt = 2px, 3x: 1pt = 3px
    /// 表示サイズが100pt × 100ptでdisplayScale = 3.0の場合、300 × 300pxの画像を用意するのがベスト(これより大きいと無駄に重い, これより小さいとぼやける)
    @Environment(\.displayScale) private var displayScale: CGFloat
    @State private var loadThumnailImage: UIImage?
    
    var body: some View {
        VStack {
            if let loadThumnailImage {
                Image(uiImage: loadThumnailImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white)
                    ProgressView()
                }
            }
        }
        .task(id: displayScale) {
            print("change displayScale")
            // サムネイル画像の生成
            guard let thumnail = await makeThumnail(maxPointSize: 100, displayScale: displayScale) else {
                print("not thumnail")
                loadThumnailImage = UIImage(systemName: "x.square")
                return
            }
            loadThumnailImage = thumnail
        }
    }
}

private extension ThumnailView {
    /// サムネイル画像の生成
    /// - note: @concurrentを付与することで呼び出しもとのActorの外で実行される
    /// - 呼び出し元がMainActorの場合はMainActor外で実行される
    @concurrent
    func makeThumnail(maxPointSize: CGFloat, displayScale: CGFloat) async -> UIImage? {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        // 元画像を取得
        let originalImage: UIImage = .thumnail
        // 表示に必要な最大ピクセル数
        let maxPixelLength = maxPointSize * displayScale
        // 目的のサイズ
        let targetSize = CGSize(width: maxPixelLength, height: maxPixelLength)
        return originalImage.preparingThumbnail(of: targetSize)
    }
}

#Preview {
    ThumnailView()
}
