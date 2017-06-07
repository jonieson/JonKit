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

    var userName : String!
//    var token : String?
    var id : String!
    var avatar : String!
    var type : String!
    var level : String!
    var count : String!
    var registTime : String!
    var signTime : String!
    
    func jsonWithData(data:JSON){
        userName = data["userName"].stringValue
        type = data["type"].stringValue
        id = data["id"].stringValue
        avatar = data["avatar"].stringValue
        level = data["level"].stringValue
        count = data["count"].stringValue
        registTime = data["registTime"].stringValue
        signTime = data["signTime"].stringValue
    }
}
