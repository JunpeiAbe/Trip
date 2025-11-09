import SwiftData
// Classに`@Model`を定義すればSwiftDataで保存可能なモデルになる
// 参考: https://zenn.dev/yumemi_inc/articles/2a929c839b2000
@Model
final class SimpleItem {
    
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}
