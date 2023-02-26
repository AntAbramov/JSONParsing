import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor
    
    private(set) var isConnected = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
}
