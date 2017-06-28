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
    //MARK: --headerRequest--methodsParamasAppendHeaders
    
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
            ]
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
    //MARK:-----uploadImageToSever---
    func uploadImageToSever(path:String,parames:[String : AnyObject]?,image:UIImage,success:@escaping (JSON)->(),fial:(String)->()){
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)

        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            /*如果上传的图片到参数，请解开注释，遍历字典注意value类型
            for (key, value)in parames{
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            */
            MultipartFormData.append(imageData!, withName: "file", fileName: "avatar.png", mimeType: "image/png")
        }, to: path) { (result) in
            switch result {
                
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        let data = JSON(response.data!)
                        success(data)
                    }
                })
            case .failure(let error):
                print(error)
                }
            }
        }
        
        
    
    
}
