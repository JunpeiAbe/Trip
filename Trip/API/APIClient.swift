import Foundation

enum APIClient {
    static func logIn(email: String, password: String) async throws -> AccessToken? {
        try await Task.sleep(nanoseconds: 5_000_000_000)
        return .init(token: UUID().uuidString)
    }
}

struct AccessToken: Codable {
    var token: String
}
