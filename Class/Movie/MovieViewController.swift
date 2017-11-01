//
//  MovieViewController.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit
import AlamofireImage
import MBProgressHUD

class MovieViewController: RootViewController {
    
    var _collectionView: UICollectionView!
    var _movieView: MovieView!
    let CellID = "cell"
    var dataSource = NSMutableArray()
    
    var count = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "电影"
        
        createCollectionView()
        
        let netWorkingStaute = NetWorking.shendInstance.netWorking()
        if netWorkingStaute == 0 {
            
            let lable = MBProgressHUD.showAdded(to: self.view, animated: true).label
            lable.text = "数据加载中…"
            lable.textColor = UIColor.gray
            getDate(0, count: count)
        }else{
            let alert: UIAlertController = UIAlertController(title: "提示", message:"请检查网络", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "退出", style: .cancel, handler: {(alert:UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func createCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (GCSCREEN_WIDTH - 30)/2, height: 240)
        
        let moiveView = MovieView()
        _movieView = moiveView
        let collection:UICollectionView =  moiveView.createCollectionView(layout: layout)
        _collectionView = collection
        self.view .addSubview(collection)
        _collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        moiveView.clickdidSelectItemAt { (collection, indexPath) in
            let dataModel = self._movieView.dataSource[indexPath.item] as! MovieModel
            let DetailedVC = DetailedViewController()
            DetailedVC._title = dataModel.title as String
            self.navigationController!.pushViewController(DetailedVC, animated: true)
        }
        weak var weakSelf = self
        moiveView.createRefreshView(footerAction: { (footer) in
            weakSelf?.count += 10
            weakSelf?.getDate((weakSelf?.count)!, count: 10)
            print("count = \((weakSelf?.count)!)")
        }) { (header) in
            weakSelf?._movieView.dataSource.removeAllObjects()
            weakSelf?.getDate(0, count: 10)
        }
    }
    // MARK: 请求数据
    func getDate(_ start:Int,count:Int) -> Void {
        MovieData.shendInstance.createGetData(url: "https://api.douban.com/v2/movie/top250?start=\(start)&count=\(count)" as NSString, responseSuccess: { (responseData) in
            guard responseData is [String: Any] else{
                print("guard \(type(of: responseData))")
                return
            }
            let dict = responseData as! Dictionary<String, AnyObject>
            if ((dict["subjects"]! as! NSArray).count > 0) {
                for subjectsDic in (dict["subjects"]! as! NSArray) {
                    let movieModel = MovieModel()
                    let subDic = subjectsDic as! Dictionary<String, AnyObject>
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
                    self._movieView.dataSource.add(movieModel)
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
        }) { (error) in
            print(error.localizedDescription)
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
