//
//  GCFoundation.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit
import Foundation

import UIKit
import Foundation

/* 导航栏高度 */
let GCNavigationH = 64.0

/* 工具栏高度 */
let GCTabBarHeight = 49.0

/* 屏幕的宽 */
var GCSCREEN_WIDTH  = UIScreen.mainScreen().bounds.size.width

/* 屏幕的高 */
var GCSCREEN_HEIGHT  = UIScreen.mainScreen().bounds.size.height

/* 屏幕的bounds */
var GCMAIN_BOUNDS: CGRect = UIScreen.mainScreen().bounds

//RGBA函数
func GCRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor
{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// MARK: - ViewW
func GCViewW (v:UIView) -> CGFloat{
    return v.frame.size.width
}
// MARK: - ViewH
func GCViewH (v:UIView) -> CGFloat{
    return v.frame.size.height
}
// MARK: - ViewX
func GCViewX (v:UIView) -> CGFloat{
    return v.frame.origin.x
}
// MARK: - ViewY
func GCViewY (v:UIView) -> CGFloat{
    return v.frame.origin.y
}
// MARK: - ViewXW
func GCViewXW (v:UIView) -> CGFloat{
    return v.frame.origin.x + v.frame.size.width
}
// MARK: - ViewYH
func GCViewYH (v:UIView) -> CGFloat{
    return v.frame.origin.y + v.frame.size.height
}
