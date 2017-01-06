//
//  DetailsViewController.swift
//  MeySwfitTest
//
//  Created by hztj on 2016/12/30.
//  Copyright © 2016年 hztj. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    var live : YKHomeCell!
    
    var backBtn : UIButton!;
    var messageBtn : UIButton? ;
    var btn2: UIButton? ;
    var btn3: UIButton? ;
    var btn4: UIButton? ;
    var btn5: UIButton? ;
    //头像
    var portraitImage: UIImageView? ;
    var imgBack: UIImageView? ;
    var nickLabel: UILabel? ;
    var moneyLabel: UILabel? ;
    var attentionLabel: UILabel? ;
    //
    var playerView: UIView!;
    var ijkPlayer: IJKMediaPlayback!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(live);
        // Do any additional setup after loading the view.
        //加载视图
        creareView();
        setPlayerView();
        bringBtnToFront();
    }
    //当DetailsViewController被销毁时调用 作用类似OC 中的dealloc();
    deinit{
        print("DetailsViewController teacher deinit")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if !self.ijkPlayer.isPlaying(){
            //开始播放
            ijkPlayer.prepareToPlay();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setPlayerView() {
        //self 弱引用 -解决闭包内存不释放的问题
        weak var weakSelf = self;
        
        self.playerView = UIView();
        view.addSubview(self.playerView);
        self.playerView.snp.makeConstraints { (make) in
            make.edges.equalTo((weakSelf?.view)!);
        }
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: live.url, with: nil);
        let playerV = ijkPlayer.view;
//        playerV?.frame = playerView.bounds;
        playerV?.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        playerView.insertSubview(playerV!, at: 1);
        
        playerV?.snp.makeConstraints({ (make) in
            make.edges.equalTo((weakSelf?.playerView)!);
        })
        ijkPlayer.scalingMode = .aspectFill;
    }
    //设置背景模糊(虚化)
    func setBg() {
        var imagUrl = URL(string:"http://img.meelive.cn/"+live.portrait);
        if(live.portrait.hasPrefix("http://")){
            imagUrl = URL(string: live.portrait);
        }
        imgBack?.kf.setImage(with: imagUrl);
        let blurEffect = UIBlurEffect(style: .light);
        let effectView = UIVisualEffectView(effect: blurEffect);
        imgBack?.addSubview(effectView);
        weak var weakSelf = self;
        effectView.snp.makeConstraints { (make) in
            make.edges.equalTo((weakSelf?.imgBack!)!);
        }
    }
    //创建视图
    func creareView() {
        //背景
        imgBack = UIImageView();
        setBg();
        imgBack?.contentMode = .scaleToFill;
        self.view.addSubview(imgBack!);
        
        //backBtn
        backBtn = UIButton(type: .custom);
//        backBtn .setTitle("x", for: .normal);
        
        backBtn .titleLabel?.textColor = UIColor.white;
        backBtn.setBackgroundImage(UIImage(named: "goback") , for: .normal);
//        backBtn .backgroundColor = UIColor.gray;
        backBtn .addTarget(self, action: #selector(backTouch), for: UIControlEvents.touchUpInside);
        self.view .addSubview(backBtn);
        
        //消息
        messageBtn = UIButton(type: .custom);
        messageBtn?.setTitle("消息", for: .normal);
        messageBtn?.setTitleColor(UIColor.white, for: .normal);
        messageBtn?.backgroundColor = UIColor.gray;
        self.view .addSubview(messageBtn!);
        
        //btn2
        btn2 = UIButton(type: .custom);
        btn2?.setTitle("btn2", for: .normal);
        btn2?.setTitleColor(UIColor.white, for: .normal);
        btn2?.backgroundColor = UIColor.gray;
        self.view .addSubview(btn2!);
        
        //btn3
        btn3 = UIButton(type: .custom);
        btn3?.setTitle("btn3", for: .normal);
        btn3?.setTitleColor(UIColor.white, for: .normal);
        btn3?.backgroundColor = UIColor.gray;
        self.view .addSubview(btn3!);
        
        //btn4
        btn4 = UIButton(type: .custom);
        //        btn4?.setTitle("btn4", for: .normal);
        btn4?.setTitleColor(UIColor.white, for: .normal);
        btn4?.setBackgroundImage(UIImage(named: "gift" ), for: .normal);
        //        btn4?.backgroundColor = UIColor.gray;
        btn4?.addTarget(self, action: #selector(touchGiftBtn), for: .touchUpInside )
        self.view .addSubview(btn4!);
        
        btn5 = UIButton(type: .custom);
        btn5?.setBackgroundImage(UIImage(named: "dz" ), for: .normal);
        btn5?.setTitleColor(UIColor.white, for: .normal);
        btn5?.addTarget(self, action: #selector(likeTouch), for: .touchUpInside);
        self.view .addSubview(btn5!);
        
        weak var weakSelf = self;
        //autoLayout
        imgBack?.snp.makeConstraints({ (make) in
            make.edges.equalTo((weakSelf?.view)!);
        })
        
        backBtn.snp.makeConstraints { (make) in
            make.width.equalTo(40);
            make.height.equalTo(40);
            make.bottom.equalTo(-20);
            make.right.equalTo(-16);
        };
       
        messageBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(16);
            make.bottom.equalTo(-20);
            make.width.height.equalTo(40);
        });
        
        btn2?.snp.makeConstraints { (make) in
            make.left.equalTo(80);
            make.bottom.equalTo(-20);
            make.width.height.equalTo(40);
        }
       
        btn3?.snp.makeConstraints { (make) in
            make.left.equalTo((weakSelf?.btn2?.snp.right)!).offset(10);
            make.bottom.equalTo(-20);
            make.width.height.equalTo(40);
        }
   
        btn4?.snp.makeConstraints { (make) in
            make.right.equalTo((weakSelf?.btn5?.snp.left)!).offset(-10);
            make.bottom.equalTo(-20);
            make.width.height.equalTo(40);
        }
        //btn5
        
        btn5?.snp.makeConstraints { (make) in
            make.right.equalTo((weakSelf?.backBtn.snp.left)!).offset(-10);
            make.bottom.equalTo(-20);
            make.width.height.equalTo(40);
        }
    }
    //送礼物特效
    func touchGiftBtn(_ sender: UIButton) {
        weak var weakSelf = self ;
        let duration = 3.0;//动画时长
        let widthCar:CGFloat = 250.0;//图片宽
        let heightCar:CGFloat = 125.0;//图片高
        
        let giftImage = UIImageView(image: #imageLiteral(resourceName: "porsche"));
        giftImage.frame = CGRect(x: 0, y: 0, width: 0, height: 0);
        view .addSubview(giftImage);
//**  snapKit 动画有问题.先用 frame 布局... **//
//        //图片的默认size位置
//        giftImage.snp.makeConstraints { (make) in
////            make.width.height.equalTo(0);
////            make.center.equalTo(0);
//            make.left.top.equalTo(10);
//            make.width.height.equalTo(10);
//        }
////        self.view.
//        self.view.setNeedsUpdateConstraints();
//        self.view.updateConstraintsIfNeeded();
////        self.view.setNeedsLayout();
//
//        let superView = self.view;
//        giftImage.snp.updateConstraints { (make) in
//            make.left.equalTo((superView?.center.x)! - widthCar/2);
//            make.top.equalTo((superView?.center.y)! - heightCar/2);
////            make.center.equalTo(superView!);
//            make.width.equalTo(widthCar);
//            make.height.equalTo(heightCar);
//        }
        //图片动画
        UIView.animate(withDuration: duration) {
            
            giftImage.frame = CGRect(x: (weakSelf?.view.center.x)! - widthCar/2, y: (weakSelf?.view.center.y)! - heightCar/2, width: widthCar, height: heightCar);
//            self.view.layoutIfNeeded()
        }
        //队列延时 (.now()现在的时间+duration动画执行时间)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { 
            UIView.animate(withDuration: duration, animations: {
                //图片透明度
                giftImage.alpha = 0;
            }, completion: { (completed) in
                //从父视图 移除图片
                giftImage.removeFromSuperview();
            })
        }
        //烟花特效
        let layerFw = CAEmitterLayer();
        view.layer.addSublayer(layerFw);
        emmitParticles(from: (messageBtn?.center)!, emitter: layerFw, in: view);
        //延时队列 当前时间之后的6s 后移除烟花🎆特效
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) { 
            layerFw.removeFromSuperlayer();
        }
        
        
    }
    //爱心动画特效
    func likeTouch(_ sender: UIButton) {
        
        let heart = DMHeartFlyView( frame: CGRect(x: 0, y: 0, width: 40, height: 40) );
        heart.center=CGPoint(x: (btn5?.frame.origin.x)!, y:  (btn5?.frame.origin.y)!);
        view.addSubview(heart);
        /* DMHeartFlyView 使用 snp 自动适配无效果 - -! */
//        heart.snp.makeConstraints { (make) in
//            make.height.width.equalTo(40);
//            make.center.equalTo((btn5?.snp.center)!);
//        }
        heart.animate(in: view);
        
        //爱心动画的关键帧动画
        let btnAnime = CAKeyframeAnimation(keyPath: "transform.scale");
        btnAnime.values =   [1.0, 0.7, 0.5, 0.3, 0.5, 0.7, 1.0, 1.2, 1.4, 1.2, 1.0,]
        btnAnime.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,];
        btnAnime.duration = 0.2;
        sender.layer.add(btnAnime, forKey: "Show");
    }
    //将界面元素放置与视图最上层
    func bringBtnToFront() {
        view.bringSubview(toFront: backBtn);
        view.bringSubview(toFront: messageBtn!);
        view.bringSubview(toFront: btn2!);
        view.bringSubview(toFront: btn3!);
        view.bringSubview(toFront: btn4!);
        view.bringSubview(toFront: btn5!);
    }
    //返回上一页
    func backTouch() {
//        ijkPlayer.pause();
//        ijkPlayer.stop();
        ijkPlayer.shutdown();
        /* _ = 加上这句话是popViewController 返回了一个 UIController _ = 忽略返回值*/
        _ = navigationController?.popViewController(animated: true);
        //显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: false);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
