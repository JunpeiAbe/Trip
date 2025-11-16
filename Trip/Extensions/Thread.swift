import Foundation

extension Thread {
    nonisolated(unsafe) static var unsafeCurrent: Thread {
        Self.current
    }
}

