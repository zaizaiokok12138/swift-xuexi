//
//  ZZcanViewController.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/8.
//  Copyright © 2018年 zaizai. All rights reserved.
//

import UIKit
import AVFoundation

class ZZcanViewController: ZZBaseViewController, AVCaptureMetadataOutputObjectsDelegate,
UIAlertViewDelegate{
    
    var ZZscanRectView:UIView!
    var ZZdevice:AVCaptureDevice!
    var ZZinput:AVCaptureDeviceInput!
    var ZZoutput:AVCaptureMetadataOutput!
    var ZZsession:AVCaptureSession!
    var ZZpreview:AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "扫描二维码"
        self.setName()
    }
    func setName(){
        do{
            self.ZZdevice = AVCaptureDevice.default(for: AVMediaType.video)
            
            self.ZZinput = try AVCaptureDeviceInput(device: ZZdevice)
            
            self.ZZoutput = AVCaptureMetadataOutput()
            ZZoutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            self.ZZsession = AVCaptureSession()
            if UIScreen.main.bounds.size.height<500 {
                self.ZZsession.sessionPreset = AVCaptureSession.Preset.vga640x480
            }else{
                self.ZZsession.sessionPreset = AVCaptureSession.Preset.high
            }
            
            self.ZZsession.addInput(self.ZZinput)
            self.ZZsession.addOutput(self.ZZoutput)
            
            self.ZZoutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            //计算中间可探测区域
            let windowSize = UIScreen.main.bounds.size
            let scanSize = CGSize(width:windowSize.width*3/4, height:windowSize.width*3/4)
            var scanRect = CGRect(x:(windowSize.width-scanSize.width)/2,
                                  y:(windowSize.height-scanSize.height)/2,
                                  width:scanSize.width, height:scanSize.height)
            //计算rectOfInterest 注意x,y交换位置
            scanRect = CGRect(x:scanRect.origin.y/windowSize.height,
                              y:scanRect.origin.x/windowSize.width,
                              width:scanRect.size.height/windowSize.height,
                              height:scanRect.size.width/windowSize.width);
            //设置可探测区域
            self.ZZoutput.rectOfInterest = scanRect
            
            self.ZZpreview = AVCaptureVideoPreviewLayer(session:self.ZZsession)
            self.ZZpreview.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.ZZpreview.frame = UIScreen.main.bounds
            self.view.layer.insertSublayer(self.ZZpreview, at:0)
            
            //添加中间的探测区域绿框
            self.ZZscanRectView = UIView();
            self.view.addSubview(self.ZZscanRectView)
            self.ZZscanRectView.frame = CGRect(x:0, y:0, width:scanSize.width,
                                             height:scanSize.height);
            self.ZZscanRectView.center = CGPoint( x:UIScreen.main.bounds.midX,
                                                y:UIScreen.main.bounds.midY)
            self.ZZscanRectView.layer.borderColor = UIColor.green.cgColor
            self.ZZscanRectView.layer.borderWidth = 1;
            
            //开始捕获
            self.ZZsession.startRunning()
        }catch _ {
            //打印错误消息
            let alertController = UIAlertController(title: "提醒",
                                                    message: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机",
                                                    preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    //通过摄像头扫描
    @IBAction func fromCamera(_ sender: AnyObject) {
       
    }
    
    //摄像头捕获
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            
            if stringValue != nil{
                self.ZZsession.stopRunning()
            }
        }
        self.ZZsession.stopRunning()
        //输出结果
        let alertController = UIAlertController(title: "二维码",
                                                message: stringValue,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
//            //继续扫描
//            self.ZZsession.startRunning()
            //停止扫描
            self.ZZsession.stopRunning()
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
