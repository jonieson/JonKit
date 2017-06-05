//
//  AnimationViewController.swift
//  JonieKit
//
//  Created by ydz on 17/4/28.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import pop

class AnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        let rotationView = UIView(frame: CGRect(x: 100, y: 250, width: 100, height: 100))
        rotationView.backgroundColor = UIColor.yellow
        self.view.addSubview(rotationView)
        /*旋转动画
        let popanimantioan = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        popanimantioan?.toValue = M_PI
        popanimantioan?.duration = 2.0
        popanimantioan?.repeatCount = 100
        rotationView.layer.pop_add(popanimantioan, forKey: "rotation")
        */
        /* 放大动画
        let animation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        animation?.toValue = NSValue(cgPoint: CGPoint(x: 2.0, y: 2.0))
        animation?.springSpeed = 1.0
        animation?.springBounciness = 4.0
        rotationView.layer.pop_add(animation, forKey: "")
         */
        /**/
        let decayAnimation = POPDecayAnimation(propertyNamed: kPOPLayerPositionX)
        decayAnimation?.velocity = 500.0
        decayAnimation?.fromValue = 50.0
        rotationView.layer.pop_add(decayAnimation, forKey: "")
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
