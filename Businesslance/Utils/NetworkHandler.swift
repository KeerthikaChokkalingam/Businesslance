//
//  NetworkHandler.swift
//  Businesslance
//
//  Created by Keerthika Chokkalingam on 15/09/23.
//

import Foundation
import SystemConfiguration
import Network

class NetworkHandler {
    private let mReachability = SCNetworkReachabilityCreateWithName(nil, "https://www.google.com")
    func checkReachable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.mReachability!, &flags)
        if isNetworkReachable(with: flags) {
            print("flags:\(flags)")
            return true
        } else {
            return false
            // return "No Connection"
        }
    }
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        return isReachable
    }
}

