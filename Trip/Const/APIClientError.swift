import Foundation
/// APIエラー
enum APIClientError: LocalizedError {
    /// URL不正
    case invalidURL
    /// リクエスト失敗
    case requestFailed(Error)
    /// レスポンス不正
    case invalidResponse(statusCode: Int)
    /// デコード失敗
    case decodingFailed
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "URLが不正です。"
        case .requestFailed(let error):
            return "リクエストに失敗しました: \(error.localizedDescription)"
        case .invalidResponse(let code):
            return "サーバーからのレスポンスが不正です。ステータスコード: \(code)"
        case .decodingFailed:
            return "レスポンスの解析に失敗しました。"
        }
    }
}

