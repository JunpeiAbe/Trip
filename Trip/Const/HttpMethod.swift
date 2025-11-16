import Foundation
/// Httpメソッド
@MainActor
enum HttpMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
}
