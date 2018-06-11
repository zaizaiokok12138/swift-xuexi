//
//  ZZKeyboardViewController.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/11.
//  Copyright © 2018年 zaizai. All rights reserved.
//

import UIKit
class ZZKeyboardViewController: ZZBaseViewController {
    
    let passnameField = UITextField.init(frame: CGRect.init(x: 20, y: ZZHeight/3, width: ZZWidth - 40, height: 30))
    let passwordField = UITextField.init(frame: CGRect.init(x: 20, y: ZZHeight/3+30+10, width: ZZWidth - 40, height: 30))
    let loginBtn = UIButton.init(frame: CGRect.init(x: 20, y: ZZHeight/3+30*2+30, width: ZZWidth - 40, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
    
    func setView(){
        self.title = "键盘高度动态变换"
        passnameField.modificationTextField(placehole: "请输入账号", keyboardType: .numberPad, text: nil)
        passwordField.modificationTextField(placehole: "请输入密码", keyboardType: .phonePad, text: nil)
        loginBtn.modificationButton(title: "登录")
        self.view.addSubview(passwordField)
        self.view.addSubview(passnameField)
        self.view.addSubview(loginBtn)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func KeyShow(note: Notification){
        let keyHeight = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        dlog(t: "键盘高度\(keyHeight)")
        if keyHeight/3 == -view.frame.origin.y{//不移动
            return
        }
        UIView.animate(withDuration: 1) {
            self.view.frame = CGRect.init(x: 0, y: -keyHeight/3, width: ZZWidth, height: ZZHeight)
        }
    }
    @objc func KeyHide(note: Notification){
        if view.frame.origin.x == 0{ //不移动
//            return
        }
        UIView.animate(withDuration: 1) {
            self.view.frame = ZZRect
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
