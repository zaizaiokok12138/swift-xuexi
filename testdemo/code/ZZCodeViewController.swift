//
//  ZZCodeViewController.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/8.
//  Copyright © 2018年 zaizai. All rights reserved.
//

import UIKit

class ZZCodeViewController: ZZBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
    func setView(){
        self.title = "二维码"
        for(index,title) in ["扫描二维码","识别二维码图片"].enumerated(){
            self.createButton(rect: CGRect.init(x: 100, y: 100 + 100 * index, width: Int(ZZWidth - 200), height: 40), title: title)
        }
    }
    //创建按钮
    func createButton(rect:CGRect,title:String){
        
        let btn = UIButton.init(frame: rect)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(SelectedBtn), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    //点击事件
    @objc func SelectedBtn(sender: UIButton){
        switch sender.currentTitle {
        case "扫描二维码"?:
            let vc = ZZcanViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "识别二维码图片"?:
            let vc = ZZImageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

