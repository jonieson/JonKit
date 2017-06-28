//
//  JonieDownloadViewController.swift
//  JonieKit
//
//  Created by ydz on 17/6/7.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import Alamofire
class JonieDownloadViewController: UIViewController {

    
    //进度条
    var valueProgress:UIProgressView!;
    //开始，停止
    var bsBtn:UIButton!;
    //下载文件的保存路径
    var destinationPath:DownloadRequest.DownloadFileDestination!;
    //用于停止下载时，保存已下载的部分
    var cancelledData: Data?;
    //下载请求对象
    var downloadRequest: DownloadRequest!;
    //获取临时文件目录内容
    var tempData : Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white;
        self.title = "下载页面";
        
        //获取临时文件数据
        let tempPathUrl = NSTemporaryDirectory()
        let fileManager = FileManager.default
        
        //设置下载路径。保存到用户文档目录，文件名不变，如果有同名文件则会覆盖
        self.destinationPath = { _, response in
            let documentsPath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
            let fileURL = documentsPath.appendingPathComponent(response.suggestedFilename!)
            //完成以后才会输出,记得这里查看地址的时候，要把地址最前面的file//去掉
            print("输出此时下载的地址位置。。。。。\(documentsPath)");
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL,[.removePreviousFile, .createIntermediateDirectories])
        }
        
        //进度条
        self.valueProgress = UIProgressView.init(frame: CGRect.init(x: 50, y: 130, width: ScreenWidth-100, height: 50));
        self.valueProgress.progressViewStyle = UIProgressViewStyle.default;
        self.valueProgress.backgroundColor = UIColor.lightGray;
        self.view.addSubview(self.valueProgress);
        //开始，停止按钮
        self.bsBtn = UIButton.init(frame: CGRect.init(x: 50, y: 150, width: ScreenWidth-100, height: 50));
        self.bsBtn.setTitle("开始下载", for: UIControlState.normal);
        self.bsBtn.setTitleColor(UIColor.blue, for: UIControlState.normal);
        self.bsBtn.isSelected = false;
        self.bsBtn.addTarget(self, action: #selector(bsBtnClick(btn:)), for: UIControlEvents.touchUpInside);
        self.view.addSubview(self.bsBtn);
        
    }
    func bsBtnClick(btn:UIButton) {
        if btn.isSelected {
            btn.setTitle("开始下载", for: UIControlState.normal);
            btn.isSelected = false;
            
            //停止下载，记录下载进度
            self.downloadRequest.cancel();
        }else{
            btn.setTitle("停止下载", for: UIControlState.normal);
            btn.isSelected = true;
            
            //请求下载
            self.httpRequest();
        }
    }
    //MARK:-------------- 下载数据请求http
    func httpRequest() {
        if (UserDefaults.standard.data(forKey: "fileOne") != nil) {
            self.cancelledData = UserDefaults.standard.object(forKey: "fileOne") as! Data?
        }
        if let cancelledData = self.cancelledData {
            self.downloadRequest = Alamofire.download(resumingWith: cancelledData,to: self.destinationPath);
        }else{
            //页面加载完毕就自动开始下载
            self.downloadRequest =  Alamofire.download(
                "http://yibudanche.oss-cn-qingdao.aliyuncs.com/dl/DANCHE-Release-3.6.0.apk", to: self.destinationPath);
            //print("111111111111");
        }
        //下载进度
        self.downloadRequest.downloadProgress(queue: DispatchQueue.main,closure: downloadProgress);
        //下载数据响应
        self.downloadRequest.responseData(completionHandler: downloadResponse);
    }
    //MARK:------------下载过程中改变进度条
    func downloadProgress(progress: Progress) {
        //进度条更新
        self.valueProgress.setProgress(Float(progress.fractionCompleted), animated: true);
        //print(Float(progress.fractionCompleted));
        print("当前进度：\(progress.fractionCompleted*100)%");
    }
    //MARK:------------下载停止响应（不管成功或者失败）
    func downloadResponse(response: DownloadResponse<Data>) {
        switch response.result {
        case .success( _):
            //self.image = UIImage(data: data)
            self.bsBtn.setTitle("下载完成", for: UIControlState.normal);
            print("文件下载完毕: \(response)");
            UserDefaults.standard.removeObject(forKey: "fileOne")
        case .failure:
            //意外终止的话，把已下载的数据储存起来
            self.cancelledData = response.resumeData;
            UserDefaults.standard.set(response.resumeData, forKey: "fileOne")
        }
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
