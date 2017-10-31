//
//  MusicViewController.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit

class MusicViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "音乐"
        self.view.backgroundColor = UIColor.cyan
        
        let btn =  CGButton.shendInstance().createButton(frame: CGRect(), bgColor: UIColor.red, title: "按钮", superView: self.view) { (action) in
            print(action)
        }
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(100)
            make.width.height.equalTo(100)
        }
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
