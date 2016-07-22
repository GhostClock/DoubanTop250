//
//  getMovieData.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit
import Alamofire

class MovieData: NSObject {

    typealias createGetDataBlock = (responseObject:NSDictionary) -> ()

    func createGetData(URL:NSString,blockProerty:createGetDataBlock){
        
        Alamofire.request(.GET,URL as String).responseJSON{ response  in
            
            if((response.result.value) != nil){
                blockProerty(responseObject: response.result.value! as! NSDictionary)
            }else{
                blockProerty(responseObject:["state":"error"])
            }
        }
    }
}
