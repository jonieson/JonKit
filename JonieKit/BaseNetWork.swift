//
//  BaseNetWork.swift
//  JonieKit
//
//  Created by ydz on 17/5/31.
//  Copyright © 2017年 jonie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class BaseNetWork: NSObject {

    //下载文件的保存路径
    var destinationPath:DownloadRequest.DownloadFileDestination!
    //用于停止下载时，保存已下载的部分
    var cancelledData: Data?
    //下载请求对象
    var downloadRequest: DownloadRequest!
    //下载进度
    var downloadProgressBlock:((AnyObject,_ fileName:String)->())?
    //文件名称
    var tempFileName : String!
    
    var manager : NetworkReachabilityManager?
        static let sharedInstance = BaseNetWork()
    override init() {
        self.manager = NetworkReachabilityManager(host: "www.baidu.com")
        self.manager?.listener = { status in
            switch status {
            case .notReachable:
                JonieToastView.instance.showToast(content: "当前没有网络")
                break
            case .unknown:
                JonieToastView.instance.showToast(content: "当前网络未知")
                break
            case .reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):
                JonieToastView.instance.showToast(content: "当前网络为WI-FI")
                break
            case .reachable(NetworkReachabilityManager.ConnectionType.wwan):
                JonieToastView.instance.showToast(content: "当前为手机流量")
                break
            
                
            }
            
        }
        self.manager?.startListening()
    }
    //MARK: --headerRequest--methodsParamasAppendHeaders
    
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
            ]
        ///MARK: --Request--
        func getRequestWithData(path:String,method:Alamofire.HTTPMethod,parames:[String : AnyObject]?,success: @escaping (JSON)->(),fail:(String)->()) {
            
            Alamofire.request(path, method: method, parameters: parames).responseJSON { (dataResponse) in
                if dataResponse.result.isSuccess{
                    let data = JSON(dataResponse.data!)
                    success(data)
                }else{
                    
                }
            }
            
        }
    //MARK:-----uploadImageToSever---
    func uploadImageToSever(path:String,parames:[String : AnyObject]?,image:UIImage,success:@escaping (JSON)->(),fial:(String)->()){
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)

        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            /*如果上传的图片到参数，请解开注释，遍历字典注意value类型
            for (key, value)in parames{
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            */
            MultipartFormData.append(imageData!, withName: "file", fileName: "avatar.png", mimeType: "image/png")
        }, to: path) { (result) in
            switch result {
                
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        let data = JSON(response.data!)
                        success(data)
                    }
                })
            case .failure(let error):
                print(error)
                }
            }
        }
        //MARK:------download----------
    func downloadFile(path: String, fileName:String,start:Bool, success:(JSON)->(), fail:(String)->()){
        
        //设置下载路径。保存到用户文档目录，文件名不变，如果有同名文件则会覆盖
        self.destinationPath = { _, response in
            let documentsPath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
            let fileURL = documentsPath.appendingPathComponent(response.suggestedFilename!)
            //完成以后才会输出,记得这里查看地址的时候，要把地址最前面的file//去掉
            print("输出此时下载的地址位置。。。。。\(documentsPath)");
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL,[.removePreviousFile, .createIntermediateDirectories])
        }
        //判断是否暂停下载，如果暂停下载则暂停对应的文件内容下载｛fileName｝＋｛start｝
        
        
        self.downloadRequest = Alamofire.download(path, to: self.destinationPath)
        
        tempFileName = fileName
        //下载进度
        self.downloadRequest.downloadProgress(queue: DispatchQueue.main,closure: downloadProgress);
        //下载数据响应
        self.downloadRequest.responseData(completionHandler: downloadResponse);
    }
    func downloadProgress(progress: Progress){
        print("当前进度：\(progress.fractionCompleted*100)%");
        self.downloadProgressBlock?(progress.fractionCompleted as AnyObject,tempFileName)
    }
    func downloadResponse(response: DownloadResponse<Data>)
    {
        switch response.result {
        case .success( _):
            print("文件下载完毕: \(response)");
            UserDefaults.standard.removeObject(forKey: "fileOne")
        case .failure:
            //意外终止的话，把已下载的数据储存起来
            self.cancelledData = response.resumeData;
            UserDefaults.standard.set(response.resumeData, forKey: "fileOne")
        }
    }
}
