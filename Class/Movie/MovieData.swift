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
    static let shendInstance = MovieData()
    private override init() {}

    func createGetData(url: NSString, responseSuccess: @escaping (_ responseData: Any) -> (), responseFaie: @escaping (_ responseError: Error) -> ()){
        let strUrl: URLRequest = URLRequest(url: URL(string: url as String)!)
        
        Alamofire.request(strUrl).responseJSON { (responseData) in
            if let json = responseData.result.value {
                responseSuccess(json)
            }else {
                responseFaie(responseData.error!)
            }
        }

    }
}
