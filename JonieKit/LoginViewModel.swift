//
//  LoginViewModel.swift
//  JonieKit
//
//  Created by ydz on 17/5/31.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import SwiftyJSON
class LoginViewModel: BaseViewModel {

    func fetchData(){
        var paramar : [String : AnyObject] = [String : AnyObject]()
        paramar["username"] = "wwwwww" as AnyObject?
        paramar["pwd"] = "12344" as AnyObject?
        BaseNetWork.sharedInstance.getRequestWithData(path: loginURL, method: .post, parames: paramar, success: { (json) in
            //此处判断请求的结果
            self.dataSet(data: json)
        }) { (fail) in
            
        }
    }
    
    //MARK: 数据组装
    func dataSet(data:JSON){
        let model = JonieDataModel()
        model.jsonWithData(data: data)
        //数据组装完成后调用闭包
        requestSuccess?(model as AnyObject)
    }
}
