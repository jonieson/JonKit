//
//  ScanViewViewController.swift
//  JonieKit
//
//  Created by ydz on 17/8/7.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import AVFoundation
class ScanViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setShadow() {
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: 100)
        
        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0, y: ScreenHeight-100, width: ScreenWidth, height: 100)
        
        let leftView = UIView()
        
        let rightView = UIView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
