//
//  MovieCollectionViewCell.swift
//  DoubanTop250
//
//  Created by GhostClock on 16/7/19.
//  Copyright © 2016年 GhostClock. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        numberLable.frame = CGRectMake(5, 2, 100, 20)
        scoreLable.frame = CGRectMake(numberLable.frame.width + 50/3, 4, 50, 14)

        imageView.frame = CGRectMake(10, numberLable.frame.origin.y + numberLable.frame.size.height + 2, self.frame.width - 10 * 2, 180)
        cnTitleLable.frame = CGRectMake(10, imageView.frame.origin.y + imageView.frame.size.height + 2, self.frame.width - 10 * 2, 15)
        enTitleLabel.frame = CGRectMake(10, cnTitleLable.frame.origin.y + cnTitleLable.frame.size.height + 2, self.frame.width - 10 * 2, 15)
        
        contentView.addSubview(numberLable)
        contentView.addSubview(scoreLable)
        contentView.addSubview(imageView)
        contentView.addSubview(cnTitleLable)
        contentView.addSubview(enTitleLabel)
        contentView.addSubview(starScoreView)
        
        self.backgroundColor = UIColor.lightGrayColor()/*UIColor(red: 230/255.0, green:153/255.0, blue:255/255.0,alpha:0.8)*/
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.grayColor().CGColor;
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowOffset = CGSizeMake(3, 3);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scoreLable:UILabel = {
        let score = UILabel()
        score.textColor = UIColor(red: 230/255.0, green:0/255.0, blue:172/255.0,alpha:1)
        score.font = UIFont(name:"Thonburi",size: 14)
        score.textAlignment = .Right
        return score
    }()
    
    var numberLable:UILabel = {
        let number = UILabel()
        number.textColor = UIColor.blackColor()
        number.font = UIFont(name:"Thonburi",size:19)
        return number
    }()
    
    var starScoreView:CWStarRateView = {
        let starScore = CWStarRateView(frame: CGRectMake(40, 4, 80, 15))
        starScore.allowIncompleteStar = false;
        starScore.hasAnimation = false;
        return starScore
    }()
    
    
    var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.whiteColor()
        return imageView
    }()
    
    var cnTitleLable:UILabel = {
        let titleLabe = UILabel()
        titleLabe.textAlignment = .Left
        titleLabe.font = UIFont(name:"Thonburi",size: 15)
        return titleLabe
    }()
    
    var enTitleLabel:UILabel = {
        let title = UILabel()
        title.textAlignment = .Left
        title.font = UIFont(name:"Thonburi",size: 12)
        return title
    }()

}
