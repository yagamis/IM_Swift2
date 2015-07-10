//
//  AppDelegate.swift
//  IMtest
//
//  Created by xiaobo on 15/6/2.
//  Copyright (c) 2015年 xiaobo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,RCIMUserInfoDataSource {

    var window: UIWindow?

    

    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        
        
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        
        switch userId {
            case "xiaobo":
            userInfo.name = "小波"
            userInfo.portraitUri = "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008"
            
            case "xiaobo2":
                userInfo.name = "小波2"
                userInfo.portraitUri = "http://v1.qzone.cc/avatar/201407/27/09/23/53d45474e1312012.jpg!200x200.jpg"
        default:
            print("无此用户")
        }
        
        return completion(userInfo)
        
        
    }
    
    
    func connectServer(completion:()->Void) {
        //获取保存的token
        let deviceTokenCache = NSUserDefaults.standardUserDefaults().objectForKey("kDeviceToken") as? String
        
        //初始化app key
        RCIM.sharedRCIM().initWithAppKey("mgb7ka1nb5iyg", deviceToken: deviceTokenCache)
        
        RCIM.sharedRCIM().connectWithToken("4LRqUHV0InlagkAbEf6hvjKtH8IlMmEOciCCZLfDAbJG8SZ6z4BDi9vFBL/0nfR4ZCL16tPrzvGgd6YoZudhew==", success: { (str:String!) -> Void in

            
            let currentUserInfo = RCUserInfo(userId: "xiaobo", name: "小波", portrait: nil)
            RCIMClient.sharedRCIMClient().currentUserInfo = currentUserInfo
            
            print("连接成功!")
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion()
            })
            
           
            

            }, error: { (code:RCConnectErrorCode) -> Void in
                print("无法连接！\(code)")
            }) { () -> Void in
                print("无效token！")
            }

        

    }
       
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        
        //设置用户信息提供者为自己 AppDelegate
        RCIM.sharedRCIM().userInfoDataSource = self
        

        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

