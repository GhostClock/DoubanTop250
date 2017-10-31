//
//  NetWorking.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/20.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit
import Alamofire

class NetWorking: NSObject {
    
    func netWorking() -> Int {
        let net = NetworkReachabilityManager()
        net?.startListening()
        var netNumber = Int()
        net?.listener = { status in
            print("网络状态\(status)")
            switch status {
            case .notReachable:
                print("not working")
                netNumber = 0
            case .unknown:
                print("unknown")
                netNumber = 1
            case .reachable(.ethernetOrWiFi):
                print("WiFi")
                netNumber = 2
            case .reachable(.wwan):
                print("wwan")
                netNumber = 3
            }
        }
        return netNumber
    }
}


