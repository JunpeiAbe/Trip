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
    /// 通信失敗
    case notConnectedInternet
    
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
        case .notConnectedInternet:
            return "ネットワークが接続されていません。"
        }
    }
    
//    var alertContent: AlertContent {
//        switch self {
//            
//        case .invalidURL:
//                .init(title: "エラー", message: errorDescription, errorCode: "エラーコード: 00001", onTapCancelButton: nil, onTapOKButton: nil)
//        case .requestFailed(_):
//                .init(title: "エラー", message: errorDescription, errorCode: "エラーコード: 00002", onTapCancelButton: {}, onTapOKButton: {})
//        case .invalidResponse(statusCode: _):
//                .init(title: "エラー", message: errorDescription, errorCode: "エラーコード: 00003", onTapCancelButton: {}, onTapOKButton: {})
//        case .decodingFailed:
//                .init(title: "エラー", message: errorDescription, errorCode: "エラーコード: 00004", onTapCancelButton: {}, onTapOKButton: {})
//        case .notConnectedInternet:
//                .init(title: "エラー", message: errorDescription, errorCode: "エラーコード: 00005", onTapCancelButton: {}, onTapOKButton: {})
//        }
//    }
}

