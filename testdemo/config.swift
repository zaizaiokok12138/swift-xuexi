//
//  config.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/8.
//  Copyright © 2018年 zaizai. All rights reserved.
//

import UIKit
#if DEBUG
    func dlog<T>(t:T){print(t)}
#else
    func dlog<T>(t:T){}
#endif

//方法
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
func kRGBColorFromHex(hex: String) -> (UIColor) {
    var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.gray
    }
    
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}
let MAIN_NAVC_COLOR           = UIColorFromRGB(rgbValue: 0x3A00A6)
let MAIN_BACK_COLOR           = UIColorFromRGB(rgbValue: 0xf0eff5)
let ZZRect                    = UIScreen.main.bounds
let ZZHeight                  = ZZRect.size.height
let ZZWidth                   = ZZRect.size.width

