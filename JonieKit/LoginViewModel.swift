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
        paramar[""] = "" as AnyObject?
        paramar[""] = "" as AnyObject?
        BaseNetWork.sharedInstance.getRequestWithData(path: "", method: .post, parames: paramar, success: { (json) in
            //此处判断请求的结果
            self.dataSet(data: json)
        }) { (fail) in
            
        }
    }
    
    //MARK: 数据组装
    func dataSet(data:JSON){
        
        
        //数据组装完成后调用闭包
    }
}
