//
//  BaseViewModel.swift
//  JonieKit
//
//  Created by ydz on 17/5/31.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {

    
    var requestSuccess : ((AnyObject)->())?
    
    func blockRequestData(success:@escaping ((AnyObject)->())){
        self.requestSuccess = success
    }
}
