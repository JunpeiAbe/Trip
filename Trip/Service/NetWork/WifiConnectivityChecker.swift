import Network
import Observation
/// Wifi接続チェック
@Observable @MainActor
final class WifiConnectivityChecker {
    
    static let shared: WifiConnectivityChecker = .init()
    private let monitor: NWPathMonitor = .init()
    private(set) var isConnected: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task {
                await self?.updateConnection()
            }
        }
        monitor.start(queue: .main)
    }
    
    deinit {
        monitor.cancel()
    }
    
    private func updateConnection() {
        let currentPath = monitor.currentPath
        let isConnected = currentPath.status == .satisfied && currentPath.usesInterfaceType(.wifi)
        self.isConnected = isConnected
    }
}

