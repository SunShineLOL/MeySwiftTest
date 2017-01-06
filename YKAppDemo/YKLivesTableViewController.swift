//
//  YKLivesTableViewController.swift
//  MeySwfitTest
//
//  Created by hztj on 2016/12/29.
//  Copyright © 2016年 hztj. All rights reserved.
//

import UIKit
import Alamofire//网络请求
import Kingfisher//图片加载
class YKLivesTableViewController: UITableViewController {

    let liveListUrl = "http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1";
    var list : [YKHomeCell] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none;
        loadList();
        //下拉刷新
        self.refreshControl = UIRefreshControl();
        refreshControl?.addTarget(self, action: #selector(loadList), for: .valueChanged);
    }
    
    func loadList(){
        Alamofire.request(liveListUrl).responseJSON { response in
            /*
            print(response.request!)  // original URL request
            print(response.response!) // HTTP URL response
            print(response.data!)     // server data
            print(response.result)   // result of response serialization
            */
            if let JSON = response.result.value {
                let lives = YKLive(fromDictionary: JSON as! NSDictionary).lives!;
                self.list = lives.map({ (lives) -> YKHomeCell in
                    return YKHomeCell(portrait: lives.creator.portrait, nick: lives.creator.nick, location: lives.creator.location, viewers: lives.onlineUsers, url: lives.streamAddr);
                })
                OperationQueue.main.addOperation {
                    self.tableView .reloadData();
                    self.refreshControl?.endRefreshing();
                }
//                print("list: \(list)")
//                dump(self.list);
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    //分组
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return list.count;
    }
    //行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1;
    }
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400;
    }
    //组高
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
 
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identtifier";
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? YJCellTableViewCell;
        if(cell == nil ){
            cell = YJCellTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier);
            //点击无效果
            cell?.selectionStyle = .none;
        }
        let live = list[indexPath.section];
        
        cell?.location?.text = live.location;
        cell?.nick?.text = live.nick;
        cell?.viewers?.text =  "\(live.viewers)";
        //小头像 
        //"http://img.meelive.cn/"+
//        let tmpStr = "http://"
        var imagUrl = URL(string:"http://img.meelive.cn/"+live.portrait);
        if(live.portrait.hasPrefix("http://")){
            imagUrl = URL(string: live.portrait);
        }
        cell?.portrait?.kf.setImage(with: imagUrl);
        
        cell?.superImage?.kf.setImage(with: imagUrl);
        return cell!
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detallsVC = DetailsViewController();
        detallsVC.live = list[indexPath.section];
        detallsVC.view.backgroundColor=UIColor.white;
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        self.navigationController?.pushViewController(detallsVC, animated: true);
        print("你点击了:\(indexPath)");
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
