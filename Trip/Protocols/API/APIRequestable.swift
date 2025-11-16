import Foundation

/// API共通のリクエスト定義
@MainActor
protocol APIRequestable: Encodable {
    associatedtype Response: APIResponsable
    associatedtype HttpBody: Codable
    /// ベースのURL
    var baseURL: String { get }
    /// エンドポイント
    var path: String { get set }
    /// httpメソッド
    var httpMethod: HttpMethod { get set }
    /// httpヘッダーフィールド
    var httpHeaderFields: [String : String] { get }
    /// httpボディ
    var httpBody: HttpBody? { get }
}

/// API共通のリクエストのデフォルト実装
extension APIRequestable {
    var baseURL: String {
        return "https://example.com"
    }
    var httpHeaderFields: [String : String] {
        return ["Content-Type" : "application/json"]
    }
    /// URLリクエスト生成
    func makeURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL.appending(path)) else {
            throw APIClientError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = httpHeaderFields
        if let httpBody {
            let data = try JSONEncoder().encode(httpBody)
            request.httpBody = data
        }
        return request
    }
}
