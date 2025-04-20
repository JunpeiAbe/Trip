import Foundation
import Observation
/// ローカルネットワーク内のサービス検索するためのクラス
@Observable @MainActor
final class LocalServiceScanner: NSObject, NetServiceDelegate, NetServiceBrowserDelegate {
    /// Bonjourサービスの検索を行うオブジェクト
    private var browser: NetServiceBrowser = .init()
    private(set) var onEvent: LocalServiceEvent?
    
    enum LocalServiceEvent {
        case resolved(host: String?, ip: String, port: Int)
        case searchFailed(error: [String : NSNumber])
        case resolveFailed(serviceName: String, error: [String : NSNumber])
    }
    // serviceType: 検索するサービスのタイプ(Bonjour/mDNSで広告されているサービスの名前)
    // 形式：_<サービス名>._<プロトコル>. （例: _http._tcp.：HTTPサービス（ウェブサーバなど）_myapp._tcp.：自分のアプリが発行している独自サービス）
    // isDomain：検索するドメイン
    // 通常はlocal.を使い、ローカルネットワーク（LAN）上のサービスを対象（例: local.：Bonjourのデフォルト。ローカルネットワーク内のmDNSサービスを探索 yourcompany.com.：独自ドメインのDNS-SD（企業向けネットワーク）
    func startBrowsing(serviceType: String = "_yourservice._tcp.") {
        browser.delegate = self
        browser.searchForServices(ofType: serviceType, inDomain: "local.")
    }
    
    // Bonjourによってサービスが1つ見つかるたびに呼ばれる
    // 取得できる情報
    // service.name：サービス名（例: "My Device"）
    // service.type：サービス種別（例: "_http._tcp."）
    // service.domain：発見されたドメイン（例: "local."）
    nonisolated func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        // delegateを設定して resolve() することでIP/ポートが取得可能になる
        service.delegate = self
        service.resolve(withTimeout: 5.0)
    }
    
    // サービスのアドレス解決が成功したときに呼ばれる
    // 取得できる情報
    // sender.hostName：ホスト名（例: "MyDevice.local."）
    // sender.port：ポート番号（例: 8080）
    nonisolated func netServiceDidResolveAddress(_ sender: NetService) {
        let addresses = sender.addresses
        // 名前解決後にhostNameがnilで返却される可能性がある
        let host = sender.hostName
        if let (ip, port) = sender.resolveIPAddress(addresses: addresses) {
            print("解決済みアドレス: \(ip):\(port)")
            Task { @MainActor in
                onEvent = .resolved(host: host, ip: ip, port: port)
            }
        }
    }
    
    // 検索失敗の検知（サービス検索エラー）
    nonisolated func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        let error = errorDict
        print("検索失敗: \(error)")
        Task { @MainActor in
            // 呼び出し元にエラー通知したい場合はクロージャーなどで通知
            onEvent = .searchFailed(error: error)
        }
    }
    
    // 名前解決失敗の検知（NetServiceのresolve失敗）
    nonisolated func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        let serviceName = sender.name
        let error = errorDict
        print("名前解決失敗: \(sender.name), エラー: \(error)")
        Task { @MainActor in
            onEvent = .resolveFailed(serviceName: serviceName, error: error)
        }
    }
}

extension NetService {
    /// NetService から最初に見つかった IPv4 or IPv6 アドレスとポートを取得
    /// - note: netServiceDidResolveAddressで直接IPアドレスを返す処理がないので、解決済みのアドレス情報を抽出しIPv4/IPv6に変換する
    func resolveIPAddress(addresses: [Data]?) -> (ip: String, port: Int)? {
        guard let addresses = addresses, let address = addresses.first else { return nil }
        var ipAddress: String?
        var port: Int?
        address.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) in
            guard let sockaddrPointer = pointer.baseAddress?.assumingMemoryBound(to: sockaddr.self) else { return }
            let sockaddr = sockaddrPointer.pointee
            
            // IPv4
            if sockaddr.sa_family == sa_family_t(AF_INET) {
                var addr = sockaddrPointer.withMemoryRebound(to: sockaddr_in.self, capacity: 1) { $0.pointee }
                var ipBuffer = [CChar](repeating: 0, count: Int(INET_ADDRSTRLEN))
                inet_ntop(AF_INET, &addr.sin_addr, &ipBuffer, socklen_t(INET_ADDRSTRLEN))
                ipAddress = String(cString: ipBuffer)
                port = Int(UInt16(bigEndian: addr.sin_port))
                print("IPv4: \(String(describing: ipAddress)):\(String(describing: port))")
            }
            
            // IPv6（必要なら）
            if sockaddr.sa_family == sa_family_t(AF_INET6) {
                var addr6 = sockaddrPointer.withMemoryRebound(to: sockaddr_in6.self, capacity: 1) { $0.pointee }
                var ipBuffer = [CChar](repeating: 0, count: Int(INET6_ADDRSTRLEN))
                inet_ntop(AF_INET6, &addr6.sin6_addr, &ipBuffer, socklen_t(INET6_ADDRSTRLEN))
                ipAddress = String(cString: ipBuffer)
                port = Int(UInt16(bigEndian: addr6.sin6_port))
                
                print("IPv6: [\(String(describing: ipAddress))]:\(String(describing: port))")
            }
        }
        if let ip = ipAddress, let port = port {
            return (ip, port)
        }
        print("IPアドレスの取得に失敗しました")
        return nil
    }
}
