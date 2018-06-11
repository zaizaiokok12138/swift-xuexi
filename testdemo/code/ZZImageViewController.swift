//
//  ZZImageViewController.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/8.
//  Copyright © 2018年 zaizai. All rights reserved.
//

import UIKit

class ZZImageViewController: ZZBaseViewController {
    
    let imageView = UIImageView.init(frame: CGRect.init(x: 20, y: 100, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
    func setView(){
        self.title = "识别二维码图片"
        imageView.image = UIImage.init(named: "github")
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        let lable = UILabel.init(frame: CGRect(x: 0, y: imageView.frame.origin.y+ZZWidth, width: ZZWidth, height: 20))
        lable.text = "长按图片识别"
        lable.textColor = UIColor.blue
        self.view.addSubview(lable)
        
        let tuchlong = UILongPressGestureRecognizer(target: self, action: #selector(tuchlongHandle(sender:)))
        imageView.addGestureRecognizer(tuchlong)
    }
    @objc func tuchlongHandle(sender:UILongPressGestureRecognizer){
        if sender.state == .began {
            /*CIDetector：iOS自带的识别图片的类*/
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
            let arr = detector?.features(in: CIImage(cgImage: (imageView.image?.cgImage)!))
            var detail = ""
            if (arr?.count)! > 0 {
                detail = (arr?.first as! CIQRCodeFeature).messageString!
            }else {
                detail = "未扫描到结果！"
            }
            let alert = UIAlertController(title: "扫描结果", message: detail, preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
