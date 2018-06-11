//
//  ZZExtension.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/11.
//  Copyright © 2018年 zaizai. All rights reserved.
//

import Foundation

import UIKit

extension UITextField{
    func modificationTextField(placehole:String, keyboardType:UIKeyboardType, text:String?){
        self.placeholder = placehole
        self.keyboardType = keyboardType
        self.text = text
        layer.cornerRadius = 10
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        textAlignment = .center
        clearButtonMode = .whileEditing
    }
}
extension UIButton{
    func modificationButton(title:String, BGColor:UIColor = .brown){
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        backgroundColor = BGColor
        layer.cornerRadius = 10
    }
}
extension Date{
    static func getCurrenTime() -> String{
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return format.string(from: date)
    }
}
