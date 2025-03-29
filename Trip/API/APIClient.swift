import Foundation
/// APIクライアント共通定義
protocol APIClientProtocol {
    static func send<Request: APIRequestable>(_ request: Request) async throws -> Request.Response
}

struct APIClient: APIClientProtocol {
    static func send<Request: APIRequestable>(_ request: Request) async throws -> Request.Response {
        let urlRequest = try request.makeURLRequest()
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: urlRequest)
        } catch {
            throw APIClientError.requestFailed(error)
        }
        if let httpResponse = response as? HTTPURLResponse,
              !(200..<300).contains(httpResponse.statusCode) {
            throw APIClientError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        do {
            return try JSONDecoder().decode(Request.Response.self, from: data)
        } catch {
            throw APIClientError.decodingFailed
        }
    }
}
