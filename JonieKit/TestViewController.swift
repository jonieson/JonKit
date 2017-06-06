//
//  TestViewController.swift
//  JonieKit
//
//  Created by ydz on 17/4/27.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var customAnimation : JonieAnimationBase!
    internal var cancelBlock: (() -> Void)?
    internal var confirmBlock: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "test"

        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
//        initBaseView()
    }
    func initBaseView(){
        
        let clearBgView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        view.addSubview(clearBgView)
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 5.0
        bgView.layer.masksToBounds = true
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.addConstraint(NSLayoutConstraint(item: bgView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 275))
        bgView.addConstraint(NSLayoutConstraint(item: bgView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 260))
        view.addSubview(bgView)
        view.addConstraint(NSLayoutConstraint(item: bgView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bgView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        
        let topImageView = UIImageView()
        topImageView.clipsToBounds = true
        topImageView.contentMode = .scaleAspectFill
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        topImageView.image = UIImage(named: "common_ic_panda")
        topImageView.addConstraint(NSLayoutConstraint(item: topImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 82))
        topImageView.addConstraint(NSLayoutConstraint(item: topImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 82))
        bgView.addSubview(topImageView)
        bgView.addConstraint(NSLayoutConstraint(item: topImageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: bgView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))
        bgView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[topImageView]", options: NSLayoutFormatOptions(), metrics: nil, views: ["topImageView":topImageView]) )
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = "hello"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 44))
        bgView.addSubview(titleLabel)
        bgView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(10)-[titleLabel]-(10)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["titleLabel":titleLabel]) )
        bgView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(125)-[titleLabel]", options: NSLayoutFormatOptions(), metrics: nil, views: ["titleLabel":titleLabel]) )
        
        let closeButton = UIButton()
        closeButton.layer.cornerRadius = 20
        closeButton.layer.masksToBounds = true
        closeButton.backgroundColor = UIColor.blue
        closeButton.setTitle("去登录", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addConstraint(NSLayoutConstraint(item: closeButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 110))
        closeButton.addConstraint(NSLayoutConstraint(item: closeButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 40))
        bgView.addSubview(closeButton)
        bgView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(18)-[closeButton]", options: NSLayoutFormatOptions(), metrics: nil, views: ["closeButton":closeButton]) )
        bgView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[closeButton]-(22)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["closeButton":closeButton]) )
        closeButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        let cancelButton = UIButton()
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.borderColor = UIColor.blue.cgColor
        cancelButton.layer.borderWidth = 0.5
        cancelButton.layer.masksToBounds = true
        cancelButton.backgroundColor = .white
        cancelButton.setTitleColor(UIColor.blue, for: .normal)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 110))
        cancelButton.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 40))
        bgView.addSubview(cancelButton)
        bgView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[cancelButton]-(18)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["cancelButton":cancelButton]) )
        bgView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[cancelButton]-(22)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["cancelButton":cancelButton]) )
        cancelButton.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
    }
    // MARK: - Action & Methods
    
    func confirmAction() {
        if let block = confirmBlock {
            self.dismiss(animated: true, completion: { () -> Void in
                block()
            })
        }
    }
    
    func dismiss(_ tap: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
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

extension TestViewController : UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if operation == UINavigationControllerOperation.push {
            return customAnimation
//        }else{
//            return nil
//        }
    }
    
}
extension TestViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JonieAnimationBase()
    }
}

