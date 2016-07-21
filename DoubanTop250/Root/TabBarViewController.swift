//
//  TabBarViewController.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBar()
       
    }
    
    func createTabBar() {
        
        let movie = MovieViewController()
        let navMovie = NavigationViewController(rootViewController:movie)
        movie.tabBarItem.image = UIImage(named: "movie")
        movie.tabBarItem.title = "电影"
        
        let music = MusicViewController()
        let navMusic = NavigationViewController(rootViewController:music)
        music.tabBarItem.image = UIImage(named: "music")
        music.tabBarItem.title = "音乐"
        
        let book = BookViewController()
        let navBook = NavigationViewController(rootViewController:book)
        book.tabBarItem.image = UIImage(named: "Book")
        book.tabBarItem.title = "书籍"
        
        self.viewControllers = [navMovie,navMusic,navBook]
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
