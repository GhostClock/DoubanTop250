//
//  NetWorking.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/20.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit

class NetWorking: NSObject {

    func netWorking() -> Int {
        
        let app = UIApplication.sharedApplication()
        let childrenArray:NSArray = app.valueForKeyPath("statusBar")!.valueForKeyPath("foregroundView")!.subviews
        var Network = Int()
        for child in childrenArray {
            if child .isKindOfClass(NSClassFromString("UIStatusBarDataNetworkItemView")!) {
                Network = child .valueForKeyPath("dataNetworkType") as! Int
            }
        }
        return Network //Network 数字对应的网络状态依次是：0：无网络；1：2G网络；2：3G网络；3：4G网络；5：WIFI信号
    }
}
