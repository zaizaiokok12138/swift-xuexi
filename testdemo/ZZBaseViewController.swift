//
//  ZZBaseViewController.swift
//  demo3
//
//  Created by zaizai on 2018/5/30.
//  Copyright © 2018年 guest. All rights reserved.
//

import UIKit

class ZZBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MAIN_BACK_COLOR
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    deinit {
        print("============\(NSStringFromClass(type(of: self)))=================")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
