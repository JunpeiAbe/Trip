import Foundation
/// WebSocket接続を行うクラス
@Observable @MainActor
final class WebSocketClient {
    private var webSocketTask: URLSessionWebSocketTask?
    private(set) var state: WebSocketState?
    
    static let shared: WebSocketClient = .init()
    
    enum WebSocketState {
        case connected
        case disconnected(error: Error?)
        case receivedText(String)
        case failedToConnect(Error)
    }
    
    /// WebSocketに接続
    func connect(url: URL) {
        let session = URLSession(configuration: .default)
        let task = session.webSocketTask(with: url)
        webSocketTask = task
        task.resume()
        // ping を送って接続確認（これで failure を検知できる）
        task.sendPing { [weak self] error in
            Task { @MainActor in
                if let error {
                    self?.state = .failedToConnect(error)
                    return
                }
                self?.state = .connected
                self?.listen()
            }
        }
    }
    
    func send(text: String) {
        let message = URLSessionWebSocketTask.Message.string(text)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("送信エラー: \(error)")
            }
        }
    }
    
    private func listen() {
        webSocketTask?.receive { [weak self] result in
            Task { @MainActor in
                switch result {
                case .success(let message):
                    switch message {
                    case .string(let text):
                        self?.state = .receivedText(text)
                    case .data(let data):
                        print("データ受信: \(data)")
                    @unknown default:
                        break
                    }
                    self?.listen()
                case .failure(let error):
                    self?.state = .disconnected(error: error)
                }
            }
        }
    }
    
    /// WebSocket切断
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
        state = .disconnected(error: nil)
    }
}
