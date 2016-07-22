//
//  MovieViewController.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit


class MovieViewController: RootViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var _collectionView:UICollectionView!
    let CellID = "cell"
    var dataSource = NSMutableArray()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "电影"
        
        createCollectionView()
        
        let netWorking = NetWorking()
        
        if netWorking.netWorking() != 0 {
            
            let lable = MBProgressHUD.showHUDAddedTo(self.view, animated: true).label
            lable.text = "数据加载中…"
            lable.textColor = UIColor.grayColor()
            
            getDate(0, count: 10)
        }else{
            
            let alert: UIAlertController = UIAlertController(title: "提示", message:"请检查网络", preferredStyle: .Alert)
            alert.addAction(cancelAction)
            
           UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    var cancelAction = UIAlertAction(title: "退出", style: .Cancel, handler:{
        (alerts: UIAlertAction!) -> Void in
        print("Cancelled")
    })
    
    
    func createCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake((GCSCREEN_WIDTH - 30)/2, 240)
        
        _collectionView = UICollectionView(frame: CGRectMake(0, 0, GCSCREEN_WIDTH, GCSCREEN_HEIGHT), collectionViewLayout: layout)
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.backgroundColor = UIColor.whiteColor()
        _collectionView .registerClass(MovieCollectionViewCell.self, forCellWithReuseIdentifier: CellID)
        
        self.view .addSubview(_collectionView)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCellWithReuseIdentifier(CellID, forIndexPath: indexPath) as! MovieCollectionViewCell
        
        cell.numberLable.text = String(indexPath.row + 1)
        
        
        let dataModel = dataSource[indexPath.item] as! MovieModel
        
//        let imageUrl:NSURL = NSURL(string: "\(dataModel.images_url["large"]!)")!
//        cell.imageView .setImageWithURL(imageUrl, placeholderImage: nil)
        cell.starScoreView.scorePercent = (dataModel.rating["average"]! as! CGFloat) / 10
        cell.scoreLable.text    =  "\(dataModel.rating["average"]! as! Double) 分"
        cell.cnTitleLable.text  =  "\(dataModel.title)"
        cell.enTitleLabel.text  =  "\(dataModel.original_title)"
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 5, 10)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let dataModel = dataSource[indexPath.item] as! MovieModel
        
        let DetailedVC = DetailedViewController()
        DetailedVC._title = dataModel.title as String
        
        self.navigationController!.pushViewController(DetailedVC, animated: true)
    }
    
    func getDate(start:Int,count:Int) -> Void {
        let data = MovieData()
        data.createGetData("https://api.douban.com/v2/movie/top250?start=\(start)&count=\(count)") { (responseObject) in
            
            if (responseObject["title"] != nil) {
                let dict:NSDictionary = responseObject 
                
                if (dict["subjects"] != nil) {
                    
                    for subjectsDic in dict["subjects"] as! NSArray{
                        let movieModel = MovieModel()
                        
                        movieModel.rating           =   subjectsDic["rating"] as! NSDictionary
                        movieModel.genres           =   subjectsDic["genres"] as! NSArray
                        movieModel.title            =   subjectsDic["title"] as! NSString
                        movieModel.casts            =   subjectsDic["casts"] as! NSArray
                        movieModel.collect_count    =   subjectsDic["collect_count"] as! Double
                        movieModel.original_title   =   subjectsDic["original_title"] as! NSString
                        movieModel.subtype          =   subjectsDic["subtype"] as! NSString
                        movieModel.directors        =   subjectsDic["directors"] as! NSArray
                        movieModel.year             =   subjectsDic["year"] as! NSString
                        movieModel.images_url       =   subjectsDic["images"] as! NSDictionary
                        movieModel.alt              =   subjectsDic["alt"] as! NSString
                        movieModel.id               =   subjectsDic["id"] as! NSString
                        
                        self.dataSource.addObject(movieModel)
                    }
                    
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    self._collectionView .reloadData()
                }else{
                    print(dict)
                }
            }else{
                print(responseObject)
            }
            
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
