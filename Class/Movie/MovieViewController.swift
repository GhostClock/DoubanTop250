//
//  MovieViewController.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit
import AlamofireImage
import MJRefresh
import MBProgressHUD
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MovieViewController: RootViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var _collectionView:UICollectionView!
    let CellID = "cell"
    var dataSource = NSMutableArray()
    let footer = MJRefreshAutoNormalFooter()
    let herder = MJRefreshNormalHeader()
    
    var count = 10
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "电影"
        
        createCollectionView()
        
        let netWorking = NetWorking()
        
        if netWorking.netWorking() != 0 {
            
            let lable = MBProgressHUD.showAdded(to: self.view, animated: true).label
            lable.text = "数据加载中…"
            lable.textColor = UIColor.gray
            getDate(0, count: count)
            
            createFooterRefresh()
        }else{
            
            let alert: UIAlertController = UIAlertController(title: "提示", message:"请检查网络", preferredStyle: .alert)
            alert.addAction(cancelAction)
            
           UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    var cancelAction = UIAlertAction(title: "退出", style: .cancel, handler:{
        (alerts: UIAlertAction!) -> Void in
        print("Cancelled")
    })
    
    
    func createCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (GCSCREEN_WIDTH - 30)/2, height: 240)
        
        _collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: GCSCREEN_WIDTH, height: GCSCREEN_HEIGHT), collectionViewLayout: layout)
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.backgroundColor = UIColor.white
        _collectionView .register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: CellID)
        
        self.view .addSubview(_collectionView)
        
        createHeaderRefresh()
    }
    //下拉加载更多
    func createFooterRefresh() -> Void {
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefreshAction))
        _collectionView.mj_footer = footer
    }
    
    func footerRefreshAction() -> Void {
        count += 10
        getDate(count, count: 10)
    }
    
    //上拉刷新
    func createHeaderRefresh() -> Void {
        herder.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefreshAction))
        _collectionView.mj_header = herder
    }
    
    func headerRefreshAction() -> Void {
        dataSource.removeAllObjects()
        getDate(0, count: 10)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! MovieCollectionViewCell
        
        cell.numberLable.text = String(indexPath.row + 1)
        
        
        let dataModel = dataSource[indexPath.item] as! MovieModel
        
        let imageUrl:URL = URL(string: "\(dataModel.images_url["large"]!)")!
        cell.imageView.af_setImage(withURL: imageUrl)
        cell.starScoreView.scorePercent = (dataModel.rating["average"]! as! CGFloat) / 10
        cell.scoreLable.text    =  "\(dataModel.rating["average"]! as! Double) 分"
        cell.cnTitleLable.text  =  "\(dataModel.title)"
        cell.enTitleLabel.text  =  "\(dataModel.original_title)"
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 5, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dataModel = dataSource[indexPath.item] as! MovieModel
        
        let DetailedVC = DetailedViewController()
        DetailedVC._title = dataModel.title as String
        
        self.navigationController!.pushViewController(DetailedVC, animated: true)
    }
    
    func getDate(_ start:Int,count:Int) -> Void {
        MovieData.shendInstance.createGetData(url: "https://api.douban.com/v2/movie/top250?start=\(start)&count=\(count)" as NSString, responseSuccess: { (responseData) in
            guard responseData is [String: Any] else{
                print("guard \(type(of: responseData))")
                return
            }
            print("----\(type(of: responseData))")
            let dict = responseData as! Dictionary<String, AnyObject>
            print(dict["title"]!)
            
//            if (dict["title"]!).boolValue {
  
                if ((dict["subjects"]! as! NSArray).count > 0) {
                    
                    for subjectsDic in (dict["subjects"]! as! NSArray) {
                        let movieModel = MovieModel()
                        let subDic = subjectsDic as! Dictionary<String, AnyObject>
                        movieModel.rating           =   subDic["rating"] as! NSDictionary
                        movieModel.rating           =   subDic["rating"] as! NSDictionary
                        movieModel.genres           =   subDic["genres"] as! NSArray
                        movieModel.title            =   subDic["title"] as! NSString
                        movieModel.casts            =   subDic["casts"] as! NSArray
                        movieModel.collect_count    =   subDic["collect_count"] as! Double
                        movieModel.original_title   =   subDic["original_title"] as! NSString
                        movieModel.subtype          =   subDic["subtype"] as! NSString
                        movieModel.directors        =   subDic["directors"] as! NSArray
                        movieModel.year             =   subDic["year"] as! NSString
                        movieModel.images_url       =   subDic["images"] as! NSDictionary
                        movieModel.alt              =   subDic["alt"] as! NSString
                        movieModel.id               =   subDic["id"] as! NSString
                        
                        self.dataSource.add(movieModel)
                    }
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self._collectionView .reloadData()
                    if (self._collectionView.mj_footer != nil && self._collectionView.mj_header != nil) {
                        self._collectionView.mj_footer.endRefreshing()
                        self._collectionView.mj_header.endRefreshing()
                    }
                }else{
                    self._collectionView.mj_footer.endRefreshingWithNoMoreData()
                }
//            }
//            else{
//                print(responseData)
//            }
        
        }) { (error) in
            
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
