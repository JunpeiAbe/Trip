import Foundation
/// 認証リクエスト
struct AuthRequest: APIRequestable {
    typealias Response = AuthResponse
    typealias HttpBody = AuthRequestBody
    var path: String = "/auth"
    var httpMethod: HttpMethod = .post
    var httpBody: AuthRequestBody?
    
    /// 認証リクエストのボディ部分
    struct AuthRequestBody: Codable {
        let mailAddress: String
        let password: String?
        let accessToken: String?
        let refreshToken: String?
        
        enum CodingKeys: String, CodingKey {
            case mailAddress = "mail_address"
            case password = "password"
            case accessToken = "access_token"
            case refreshToken = "refresh_token"
        }
    }
    /// tokenなしの場合
    init(
        mailAddress: String,
        password: String
    ) {
        self.httpBody = AuthRequestBody(
            mailAddress: mailAddress,
            password: password,
            accessToken: nil,
            refreshToken: nil
        )
    }
    /// tokenあり かつ 有効期限切れでない場合
    init(
        mailAddress: String,
        accessToken: String
    ) {
        self.httpBody = AuthRequestBody(
            mailAddress: mailAddress,
            password: nil,
            accessToken: accessToken,
            refreshToken: nil
        )
    }
    /// tokenあり かつ 有効期限切れの場合
    init(
        mailAddress: String,
        password: String,
        refreshToken: String
    ) {
        self.httpBody = AuthRequestBody(
            mailAddress: mailAddress,
            password: nil,
            accessToken: nil,
            refreshToken: refreshToken
        )
    }
}
