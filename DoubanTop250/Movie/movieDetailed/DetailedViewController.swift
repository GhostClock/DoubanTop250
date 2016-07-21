//
//  DetailedViewController.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/21.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var _title:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = _title
        self.view.backgroundColor = UIColor.brownColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
