import Foundation
/// 認証レスポンス
struct AuthResponse: APIResponsable {
    /// アクセストークン
    var accessToken: String
    /// リフレッシュトークン
    var refreshToken: String
    /// アクセストークンの有効期限
    var expireDate: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expireDate = "expire_date"
    }
    
    init(
        accessToken: String,
        refreshToken: String,
        expireDate: String
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expireDate = expireDate
    }
}
