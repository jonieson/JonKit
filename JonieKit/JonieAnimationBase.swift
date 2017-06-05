//
//  JonieAnimationBase.swift
//  JonieKit
//
//  Created by ydz on 17/4/27.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import pop

class JonieAnimationBase: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {

    //屏幕
    let ScreenWidth     = UIScreen.main.bounds.width
    let ScreenHeight    = UIScreen.main.bounds.height
    
    enum JonieAnimationType : Int{
        case Present = 1
        case Miss
        case Push
        case Pop
        case EndPop
    }
    var animationDurationTime : Double!///动画时间
    
    var animationType : JonieAnimationType! ///动画类型
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return animationDurationTime
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view
        fromView?.tintAdjustmentMode = UIViewTintAdjustmentMode.dimmed
        fromView?.isUserInteractionEnabled = false
        
        let dimmingView = UIView(frame:(fromView?.bounds)!)
        dimmingView.backgroundColor = UIColor.black
        dimmingView.layer.opacity = 0.0
        
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        toView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        toView?.center = CGPoint(x: transitionContext.containerView.center.x, y: transitionContext.containerView.center.y)
        transitionContext.containerView.addSubview(dimmingView)
        transitionContext.containerView.addSubview(toView!)
        
        let positionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        positionAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 0.01, y: 0.01))
        positionAnimation?.springBounciness = 10
        positionAnimation?.completionBlock = {(anim, finished) -> Void in transitionContext.completeTransition(true)}
        
        let opacityAnimation = POPBasicAnimation(propertyNamed:kPOPLayerOpacity)
        opacityAnimation?.toValue = 0.7
        
        toView?.layer.pop_add(positionAnimation, forKey: "positionAnimation")
        dimmingView.layer.pop_add(opacityAnimation, forKey:"opacityAnimation")
    }
    
}

