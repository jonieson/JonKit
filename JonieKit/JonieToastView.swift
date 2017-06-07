//
//  JonieToastView.swift
//  JonieKit
//
//  Created by ydz on 17/6/5.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import SnapKit
class JonieToastView: NSObject {

    static var instance : JonieToastView = JonieToastView()
    
    var windows = UIApplication.shared.windows
    let realVision = (UIApplication.shared.keyWindow?.subviews.first)! as UIView
    
    //MARK: --showToastMessage--
    func showToast(content:String){
        clear()
        let frame = CGRect(x: 0, y: 0, width: 150, height: 35)
        let toastContainView = UIView()
        toastContainView.layer.cornerRadius = 10
        toastContainView.backgroundColor = UIColor.black
        toastContainView.alpha = 0.7
        
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        window.frame = frame
        toastContainView.frame = frame
        
        window.windowLevel = UIWindowLevelAlert
        window.center = CGPoint(x: realVision.center.x, y: realVision.center.y * 16/10)
        window.isHidden = false
        window.addSubview(toastContainView)
        windows.append(window)
        
        let alertString = UILabel()
        alertString.textColor = UIColor.white
        alertString.font = UIFont.systemFont(ofSize: 12)
        alertString.textAlignment = NSTextAlignment(rawValue: 1)!
        alertString.text = content
        toastContainView.addSubview(alertString)
        alertString.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        perform(#selector(removeToast(sender:)), with: window, afterDelay: 1.5)
    
    }
    func removeToast(sender : AnyObject){
        if let window = sender as? UIWindow {
            if let index = windows.index(where: { (item) -> Bool in
                return item == window
            }) {
                
                windows.remove(at: index)
            }
        }else{
            
        }
    }
    func clear() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        windows.removeAll(keepingCapacity: false)
    }
    
}

