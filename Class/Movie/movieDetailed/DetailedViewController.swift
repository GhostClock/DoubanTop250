//
//  DetailedViewController.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/21.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit

@objc protocol DetailedViewControllerDelegate {
   @objc optional func changeValue (value:Int) -> Void;
}

class DetailedViewController: UIViewController {
    
    var _title:String?
    var delegate: DetailedViewControllerDelegate?
    var count:Int = 0
    
    var changeBlock:((Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = _title
        self.view.backgroundColor = UIColor.brown
        
        weak var weakSelf = self
        let btn =  CGButton.shendInstance().createButton(frame: CGRect(), bgColor: UIColor.red, title: "按钮", superView: self.view) { (action) in
            weakSelf?.count += 1
            let cout = weakSelf?.count
            // Block回调
            if (weakSelf?.changeBlock! != nil) {
                weakSelf?.changeBlock!(cout!)
            }
            
            // 代理回调
            if ((weakSelf?.delegate?.changeValue) != nil) {
                weakSelf?.delegate?.changeValue!(value: cout!)
            }
        }
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(100)
            make.width.height.equalTo(100)
        }
    }
    
    func changeValue(value:@escaping (Int) -> ()) -> Void {
        self.changeBlock = value
    }
    
    deinit {
        print("DetailedViewController deinit")
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
