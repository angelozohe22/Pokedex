//
//  PDNetworkReachability.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Network

final public class PDNetworkReachability {
    
    // MARK: - Properties
    
    public static let shared = PDNetworkReachability()
    
    private let monitor = NWPathMonitor()
    
    public var isConnected: Bool { monitor.currentPath.status == .satisfied }
    
    private var isMonitoring = false
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Functions
    
    public func startMonitoring() {
        if isMonitoring { return }
        isMonitoring = true
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        if isMonitoring {
            monitor.cancel()
            isMonitoring = false
        }
    }
    
}
