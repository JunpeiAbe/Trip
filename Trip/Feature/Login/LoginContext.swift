import Foundation

final class LoginContext: Sendable {
    let accessToken: AccessToken
    
    init(accessToken: AccessToken) {
        self.accessToken = accessToken
    }
}
