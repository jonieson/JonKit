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

        static let sharedInstance = BaseNetWork()
    //MARK: --headerRequest--
    /*
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
    */
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
