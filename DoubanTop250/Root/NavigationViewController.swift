//
//  NavigationViewController.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController,UINavigationControllerDelegate{
    
    var _delegate:UIGestureRecognizerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavBar()

    }
    
    func customNavBar() {

        self.navigationBar.barTintColor = UIColor.lightGrayColor()
        
        let dict:NSDictionary = NSDictionary(object: UIColor(red: 255/255.0, green:255/255.0,blue:255/255.0,alpha:1),forKey:NSForegroundColorAttributeName)
        navigationBar.titleTextAttributes = dict as? [String : AnyObject]
        
        self.delegate = self
        _delegate = self.interactivePopGestureRecognizer?.delegate
    }
    
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        self.navigationBar.hidden = false
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        
        if viewController != navigationController.viewControllers[0] {
            viewController.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        }else{
            viewController.navigationController?.interactivePopGestureRecognizer?.delegate = _delegate
        }
        
        
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count >= 1 {
            self.navigationItem.hidesBackButton = true
            let button = UIButton()
            button.addTarget(self, action:#selector(NavigationViewController.back(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button.frame = CGRectMake(0, 4, 36, 36);
            button .setImage(UIImage(named: "hb_subbackN"), forState: UIControlState.Normal)
            button .setImage(UIImage(named: "hb_subbackH"), forState: UIControlState.Highlighted)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
            
            let buttonLeft = UIBarButtonItem()
            buttonLeft.customView = button
            
            viewController.navigationItem.leftBarButtonItem = buttonLeft
            viewController.navigationItem.leftBarButtonItem?.customView = button
            
            buttonLeft.customView = button
            
            viewController.hidesBottomBarWhenPushed = true
        }
        if self.childViewControllers.count == 2 {
            viewController.hidesBottomBarWhenPushed = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    func back(button:UIButton!) {
        self.popViewControllerAnimated(true)
    }
    
    
    override func shouldAutorotate() -> Bool {
        return (self.topViewController?.shouldAutorotate())!
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return (self.topViewController?.supportedInterfaceOrientations())!
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
