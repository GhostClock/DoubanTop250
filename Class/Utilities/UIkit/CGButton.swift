//
//  CGButton.swift
//  DoubanTop250
//
//  Created by GhostClock on 2017/10/31.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

import UIKit

class CGButton: UIView {
  
    static let instance: CGButton = CGButton()
    class func shendInstance() -> CGButton {
        return instance
    }
    
    private var blockAction:((UIButton) -> Void)?
    func createButton(frame: CGRect, bgColor: UIColor, title: NSString, superView:UIView, buttonAction: @escaping (UIButton) -> ()) -> UIButton {
        let btn = UIButton()
        btn.frame = frame
        btn.backgroundColor = bgColor
        btn.titleLabel?.text = title as String
        superView.addSubview(btn)
        btn.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        blockAction = buttonAction
        return btn
    }
    @objc func buttonAction(sender:UIButton) {
        if (blockAction != nil) {
            blockAction!(sender)
        }
    }
}
