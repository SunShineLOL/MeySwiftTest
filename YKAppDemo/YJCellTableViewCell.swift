//
//  YJCellTableViewCell.swift
//  MeySwfitTest
//
//  Created by hztj on 2016/12/29.
//  Copyright © 2016年 hztj. All rights reserved.
//

import UIKit
import SnapKit
class YJCellTableViewCell: UITableViewCell {

    public var portrait : UIImageView?;
    public var nick : UILabel?;
    var location : UILabel?;
    var viewers : UILabel?;
    var superImage : UIImageView?;
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        let sView = self.contentView;
        //头像
        portrait = UIImageView();
        portrait?.layer.cornerRadius = 20.0;
        portrait?.clipsToBounds = true;
        portrait?.backgroundColor = UIColor.yellow;
        sView .addSubview(portrait!);
        portrait?.contentMode = UIViewContentMode.scaleAspectFill;
        portrait?.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5);
            make.top.equalTo(5);
            make.width.equalTo(40);
            make.height.equalTo(40);
        };
        //昵称
        nick = UILabel();
        nick?.text = "这是昵称";
        nick?.font = UIFont.systemFont(ofSize: 16.0);
        sView.addSubview(nick!);
        nick?.snp.makeConstraints({ (make) in
            make.left.equalTo(portrait!.snp.right).offset(5);
            make.top.equalTo(7);
            make.right.equalTo(-100);
        });
        //地址图标
        let locantionImage = UIImageView(image: #imageLiteral(resourceName: "address-1"));
        locantionImage.contentMode = UIViewContentMode.scaleAspectFill;
        sView.addSubview(locantionImage);
        locantionImage.snp.makeConstraints { (make) in
            make.height.equalTo(15);
            make.width.equalTo(15);
            make.left.equalTo(nick!);
//            make.left.equalTo((portrait?.snp.right)!);
            make.top.equalTo((nick?.snp.bottom)!).offset(2);
        }
        //地址
        location = UILabel();
        location?.text = "地址";
        location?.font = UIFont.systemFont(ofSize: 14.0);
        location!.textColor = UIColor.gray;
        sView.addSubview(location!);
        location?.snp.makeConstraints({ (make) in
            make.left.equalTo(locantionImage.snp.right).offset(2);
//            make.top.equalTo(nick!.snp.bottom).offset(3);
            make.centerY.equalTo(locantionImage.snp.centerY);
            make.right.equalTo(nick!);
        });
        //人数
        viewers = UILabel();
        viewers?.text = "19999";
        viewers?.numberOfLines = 1;
        viewers!.textColor = UIColor.red;
        viewers?.font = UIFont.systemFont(ofSize: 16.0);
        viewers?.textAlignment = NSTextAlignment.right;
        sView.addSubview(viewers!);
        viewers?.snp.makeConstraints { (make) in
            make.right.equalTo(-16);
            make.width.equalTo(100-16);
            make.centerY.equalTo(nick!.snp.centerY);
        }
        let viewLabel = UILabel();
        viewLabel.text = "在看";
        viewLabel.textColor = UIColor.gray;
        viewLabel.font = UIFont.systemFont(ofSize: 14.0);
        viewLabel.textAlignment = .right;
        sView .addSubview(viewLabel);
        viewLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-16);
            make.top.equalTo((viewers?.snp.bottom)!).offset(2);
//            make.centerY.equalTo((location?.snp.centerY)!);
        };
        //大图
        superImage = UIImageView();
        superImage?.backgroundColor = UIColor.blue;
        superImage?.image = UIImage(named:"123");
        superImage?.contentMode = UIViewContentMode.scaleAspectFill;
        superImage?.clipsToBounds = true;
        sView.addSubview(superImage!);
        superImage?.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.bottom.equalTo(-8);
            make.top.equalTo(50);
        }
        //底部分割线
        let lineView = UIView();
        lineView.backgroundColor = UIColor.gray;
        lineView.alpha = 0.2;
        sView .addSubview(lineView);
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo((superImage?.snp.bottom)!);
            make.left.right.bottom.equalTo(0);
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
