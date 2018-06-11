//
//  ZZMainViewController.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/8.
//  Copyright © 2018年 zaizai. All rights reserved.
//

import UIKit



class ZZMainViewController: ZZBaseViewController {
    
    var arrcell = [String]()   //数据源
    let mainTabelview = UITableView.init(frame: ZZRect) //创建UITableView
    let cellIndetifier = "Maincell" //Cell标识符
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
    
    func setView(){
        self.title = "第一页"
        self.arrcell = ["二维码扫描","FMDB","键盘高度","定位","动画为背景","本地播放音乐","语音","模糊搜索"]
        self.mainTabelview.delegate = self
        self.mainTabelview.dataSource = self
        self.mainTabelview.tableFooterView = UIView()
        self.view.addSubview(self.mainTabelview)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK----------------UITableViewDelegate, UITableViewDataSource----------
extension ZZMainViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrcell.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier) ?? UITableViewCell.init(style: .default, reuseIdentifier: cellIndetifier)
        cell.textLabel?.text = arrcell[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let mainvc = ZZCodeViewController()
            self.navigationController?.pushViewController(mainvc, animated: true)
        }else if indexPath.row == 1{
            let mainvc = ZZFMDBViewController()
            self.navigationController?.pushViewController(mainvc, animated: true)
        }else if indexPath.row == 2{
            
        }else if indexPath.row == 3{
            
        }else if indexPath.row == 4{
            
        }else if indexPath.row == 5{
            
        }else if indexPath.row == 6{
            
        }else if indexPath.row == 7{
            
        }
    }
    
    
}

