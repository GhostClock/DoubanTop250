//
//  MovieCollectionViewCell.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        numberLable.frame = CGRect(x: 5, y: 2, width: 100, height: 20)
        scoreLable.frame = CGRect(x: numberLable.frame.width + 50/3, y: 4, width: 50, height: 14)

        imageView.frame = CGRect(x: 10, y: numberLable.frame.origin.y + numberLable.frame.size.height + 2, width: self.frame.width - 10 * 2, height: 180)
        cnTitleLable.frame = CGRect(x: 10, y: imageView.frame.origin.y + imageView.frame.size.height + 2, width: self.frame.width - 10 * 2, height: 15)
        enTitleLabel.frame = CGRect(x: 10, y: cnTitleLable.frame.origin.y + cnTitleLable.frame.size.height + 2, width: self.frame.width - 10 * 2, height: 15)
        
        contentView.addSubview(numberLable)
//        numberLable.snp.makeConstraints { (make) in
//            make.left.equalTo(5)
//            make.top.equalTo(2)
//            make.width.equalTo(100)
//            make.height.equalTo(20)
//        }
        contentView.addSubview(scoreLable)
//        scoreLable.snp.makeConstraints { (make) in
//            make.left.equalTo(numberLable).offset(50/3)
//            make.top.equalTo(4)
//            make.width.equalTo(50)
//            make.height.equalTo(14)
//        }
        contentView.addSubview(imageView)
//        imageView.snp.makeConstraints { (make) in
//            make.left.equalTo(10)
//            make.top.equalTo(numberLable).offset(2)
//            make.width.equalTo(self.frame.width - 10 * 2)
//            make.height.equalTo(180)
//        }
        contentView.addSubview(cnTitleLable)
        contentView.addSubview(enTitleLabel)
        contentView.addSubview(starScoreView)
        
        self.backgroundColor = UIColor.lightGray/*UIColor(red: 230/255.0, green:153/255.0, blue:255/255.0,alpha:0.8)*/
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.gray.cgColor;
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowOffset = CGSize(width: 3, height: 3);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scoreLable:UILabel = {
        let score = UILabel()
        score.textColor = UIColor(red: 230/255.0, green:0/255.0, blue:172/255.0,alpha:1)
        score.font = UIFont(name:"Thonburi",size: 14)
        score.textAlignment = .right
        return score
    }()
    
    var numberLable:UILabel = {
        let number = UILabel()
        number.textColor = UIColor.black
        number.font = UIFont(name:"Thonburi",size:19)
        return number
    }()
    
    var starScoreView:CWStarRateView = {
        let starScore = CWStarRateView(frame: CGRect(x: 40, y: 4, width: 80, height: 15))
        starScore.allowIncompleteStar = false;
        starScore.hasAnimation = false;
        return starScore
    }()
    
    
    var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    var cnTitleLable:UILabel = {
        let titleLabe = UILabel()
        titleLabe.textAlignment = .left
        titleLabe.font = UIFont(name:"Thonburi",size: 15)
        return titleLabe
    }()
    
    var enTitleLabel:UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont(name:"Thonburi",size: 12)
        return title
    }()

}
