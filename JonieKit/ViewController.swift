//
//  ViewController.swift
//  JonieKit
//
//  Created by ydz on 17/4/27.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var customAnimation : JonieAnimationBase!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        let login = LoginViewModel()
        login.fetchData()
        
        login.blockRequestData { (response) in
            let model = response as! JonieDataModel
            print(model.userName as Any)
        }
//        JonieToastView.instance.showToast(content: "hello world,everybody come baby let us go")
        
    }

    
    @IBAction func push(_ sender: Any) {
        /*
        let nextVc = TestViewController()
        nextVc.transitioningDelegate = nextVc
        nextVc.modalPresentationStyle = UIModalPresentationStyle.custom
        navigationController?.present(nextVc, animated: true, completion: { () -> Void in
        })
        */
        let downloadVc = JonieDownloadViewController()
        navigationController?.pushViewController(downloadVc, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
//        if operation == UINavigationControllerOperation.push {
            return nil
//        }else if(operation == UINavigationControllerOperation.pop){
//            return customAnimation
//        }else{
//            return nil
//        }
 
    }
}
extension ViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

