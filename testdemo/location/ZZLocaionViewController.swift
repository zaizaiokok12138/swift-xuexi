//
//  ZZLocaionViewController.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/11.
//  Copyright © 2018年 zaizai. All rights reserved.
//


//---------
/*
 需要导入CoreLocation.framework框架
 需要在真机开启定位
 */
import UIKit
import CoreLocation

let rectbtn = CGRect.init(x: 30, y: ZZHeight - 150, width: ZZWidth - 60, height: 80)
let rectLabe = CGRect.init(x: 10, y: 80, width: ZZWidth-20, height: 20)

class ZZLocaionViewController: ZZBaseViewController, CLLocationManagerDelegate{
    
    let btn = UIButton.init(frame: rectbtn)
    let lab = UILabel.init(frame: rectLabe)
    let locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showEventsAcessDeniedAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
    func setView(){
        self.title = "定位"
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //精准度
        locationManager.requestAlwaysAuthorization() // 发送定位请求
        
        
        
        self.view.layer.contents = UIImage.init(named: "bg")?.cgImage
        //毛玻璃效果
        let visual = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .dark))
        visual.frame = ZZRect
        
        lab.text = "未定位"
        lab.textColor = UIColor.white
        lab.textAlignment = .center
        btn.modificationButton(title: "定位", BGColor: .green)
        btn.addTarget(self, action: #selector(findlocation), for: .touchUpInside)
        self.view.addSubview(visual)
        self.view.addSubview(lab)
        self.view.addSubview(btn)
        
    }
    
    @objc func findlocation(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingHeading()
        }else{
            locationManager.requestAlwaysAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lab.text = "error:\(error.localizedDescription)"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newlocation = locations.first{
            CLGeocoder().reverseGeocodeLocation(newlocation, completionHandler: { (pms, err) in
                if (pms?.last?.location?.coordinate) != nil {
                    manager.stopUpdatingLocation()//停止定位，节省电量，只获取一次定位
                    
                    //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
                    let placemark:CLPlacemark = (pms?.last)!
                    print(placemark)
                    let name: String? = placemark.name;//地名
                    let thoroughfare: String? = placemark.thoroughfare;//街道
                    let subThoroughfare: String? = placemark.subThoroughfare; //街道相关信息，例如门牌等
                    let locality: String? = placemark.locality; // 城市
                    //别的含义
                    //let location = placemark.location;//位置
                    //let region = placemark.region;//区域
                    //let addressDic = placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
                    //let subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
                    //let administrativeArea=placemark.administrativeArea; // 州
                    //let subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
                    //let postalCode=placemark.postalCode; //邮编
                    //let ISOcountryCode=placemark.ISOcountryCode; //国家编码
                    //let country=placemark.country; //国家
                    //let inlandWater=placemark.inlandWater; //水源、湖泊
                    //let ocean=placemark.ocean; // 海洋
                    //let areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
                    
                    //                    self.label.text = String(name ?? "-")+String(thoroughfare ?? "-")+String(subThoroughfare ?? "-")+String(locality ?? "-")
                    let str =  name ?? "-"
                    let str1 = thoroughfare ?? "-"
                    let str2 = subThoroughfare ?? "-"
                    let str3 = locality ?? "-"
                    self.lab.text = str + str1 + str2 + str3
                }
            })
        }
    }
    
    // 跳转到设置界面获得位置授权
    
    func showEventsAcessDeniedAlert() {
        
        
        
        if(CLLocationManager.authorizationStatus() != .denied) {
            
            print("应用拥有定位权限")
            
        }else {
            
            let alertController = UIAlertController(title: "打开定位开关",
                                                    
                                                    message: "定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,并允许App使用定位服务",
                                                    
                                                    preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "设置", style: .default) { (alertAction) in
                
                
                
                if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                    
                    UIApplication.shared.openURL(appSettings as URL)
                    
                }
                
            }
            
            alertController.addAction(settingsAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
