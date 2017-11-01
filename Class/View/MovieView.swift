//
//  MoveView.swift
//  DoubanTop250
//
//  Created by GhostClock on 2017/11/1.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

import UIKit
import MJRefresh

class MovieView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var _collectionView:UICollectionView!
    let CellID = "cell"
    var dataSource = NSMutableArray()
    let footer = MJRefreshAutoNormalFooter()
    let herder = MJRefreshNormalHeader()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCollectionView(layout: UICollectionViewFlowLayout) ->  UICollectionView{
        _collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.backgroundColor = UIColor.white
        _collectionView .register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: CellID)
        return _collectionView
    }
    
    // MARK: UICollectionView的代理方法
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
        cell.scoreLable.text    =  "\(dataModel.rating["average"]! as! Double)分"
        cell.cnTitleLable.text  =  "\(dataModel.title)"
        cell.enTitleLabel.text  =  "\(dataModel.original_title)"
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 5, 10)
    }
    
    // MARK: 点击Item事件
    var clickItemBlock:((UICollectionView, IndexPath) -> Void)?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (clickItemBlock != nil) {
            clickItemBlock!(collectionView, indexPath)
        }
    }
    func clickdidSelectItemAt(clickBlock:@escaping (UICollectionView, IndexPath) -> Void) -> Void {
        clickItemBlock = clickBlock
    }
    
    // MARK: 下拉加载更多 上拉刷新
    var footerRefreshActionBlock:((_ footer:MJRefreshAutoNormalFooter) -> Void)?
    var headerRefreshActionBlock:((_ herder: MJRefreshNormalHeader) -> Void)?
    
    func createRefreshView(footerAction:@escaping ((_ footer:MJRefreshAutoNormalFooter) -> Void), headerAction:@escaping ((_ herder: MJRefreshNormalHeader) -> Void)) -> Void {
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefreshAction))
        _collectionView.mj_footer = footer
        footerRefreshActionBlock = footerAction
        
        herder.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefreshAction))
        _collectionView.mj_header = herder
        headerRefreshActionBlock = headerAction
    }
    @objc private func footerRefreshAction() -> Void {
        if footerRefreshActionBlock != nil {
            footerRefreshActionBlock!(footer)
        }
    }
    @objc private  func headerRefreshAction() -> Void {
        if headerRefreshActionBlock != nil {
            headerRefreshActionBlock!(herder)
        }
    }
    
    
    
}
