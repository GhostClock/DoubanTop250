//
//  getMovieData.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit

class MovieData: NSObject {

    typealias createGetDataBlock = (responseObject:AnyObject) -> ()

    func createGetData(URL:NSString,blockProerty:createGetDataBlock){
        
        let manager = AFHTTPSessionManager()
        manager.GET(URL as String, parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, responseObject:AnyObject?) in
            
            blockProerty(responseObject: responseObject!)  //需要拆包
            
        }) { (task:NSURLSessionDataTask?, error:NSError) in
            
            blockProerty(responseObject: error)
        }
    }
}
