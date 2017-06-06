//
//  JonieDataModel.swift
//  JonieKit
//
//  Created by ydz on 17/6/6.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import SwiftyJSON
class JonieDataModel: NSObject {

    var userName : String?
    var token : String?
    var userId : String?
    var avatar : String?
    
    func jsonWithData(data:JSON){
        userName = data[""].stringValue
        token = data[""].stringValue
        userId = data[""].stringValue
        avatar = data[""].stringValue
    }
}
