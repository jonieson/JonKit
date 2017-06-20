//
//  BaseNetWork.swift
//  JonieKit
//
//  Created by ydz on 17/5/31.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class BaseNetWork: NSObject {

    var manager : NetworkReachabilityManager?
        static let sharedInstance = BaseNetWork()
    override init() {
        self.manager = NetworkReachabilityManager(host: "www.baidu.com")
        self.manager?.listener = { status in
            switch status {
            case .notReachable:
                JonieToastView.instance.showToast(content: "当前没有网络")
                break
            case .unknown:
                JonieToastView.instance.showToast(content: "当前网络未知")
                break
            case .reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):
                JonieToastView.instance.showToast(content: "当前网络为WI-FI")
                break
            case .reachable(NetworkReachabilityManager.ConnectionType.wwan):
                JonieToastView.instance.showToast(content: "当前为手机流量")
                break
            
                
            }
            
        }
        self.manager?.startListening()
    }
    //MARK: --headerRequest--
    
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
            ]
    Alamofire.request(path, method: method, parameters: parames,headers: headers).responseJSON { (dataResponse) in
    if dataResponse.result.isSuccess{
    let data = JSON(dataResponse.data!)
    success(data)
    }else{
    
    }
    }
    
        ///MARK: --Request--
        func getRequestWithData(path:String,method:Alamofire.HTTPMethod,parames:[String : AnyObject]?,success: @escaping (JSON)->(),fail:(String)->()) {
            
            Alamofire.request(path, method: method, parameters: parames).responseJSON { (dataResponse) in
                if dataResponse.result.isSuccess{
                    let data = JSON(dataResponse.data!)
                    success(data)
                }else{
                    
                }
            }
            
        }
    
    
}
