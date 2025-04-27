//
//  ReachabilityService.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 28.04.2025.
//

import Network
import Reachability
import Foundation

extension Notification.Name {
  static let networkStatusChanged = Notification.Name("NetworkStatusChanged")
}

protocol ReachabilityServiceProtocol {
  var isConnected: Bool { get }
}

class ReachabilityService: ReachabilityServiceProtocol {
  
  static let shared = ReachabilityService()
  private let reachability: Reachability
  private var lastStatus: Bool? = nil
  
  var isConnected: Bool {
    return reachability.connection != .unavailable
  }
  
  private init() {
    do {
      reachability = try Reachability()
#if targetEnvironment(simulator)
      /// Reachabiility works incorrect on simulators
#else
      startMonitoring()
#endif
      
    } catch {
      fatalError("Unable to start Reachability: \(error.localizedDescription)")
    }
  }
  
  private func startMonitoring() {
    do {
      try reachability.startNotifier()
    } catch {
      print("Unable to start notifier: \(error.localizedDescription)")
    }
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(reachabilityChanged),
                                           name: .reachabilityChanged,
                                           object: reachability)
    
  }
  
  
  @objc func reachabilityChanged(note: Notification) {
    let reachability = note.object as? Reachability
    let connected = reachability?.connection != .unavailable
    handleStatusChange(isConnected: connected)
  }
  func stopMonitoring() {
    reachability.stopNotifier()
  }
  
  private func handleStatusChange(isConnected: Bool) {
    guard lastStatus != isConnected else { return }
    lastStatus = isConnected
    
    DispatchQueue.main.async {
      NotificationCenter.default.post(
        name: .networkStatusChanged,
        object: nil,
        userInfo: ["isConnected": isConnected]
      )
    }
  }
}
