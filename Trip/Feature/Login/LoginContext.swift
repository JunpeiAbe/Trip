import Foundation

final class LoginContext: Sendable {
    let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}
