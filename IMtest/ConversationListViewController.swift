//
//  ConversationListViewController.swift
//  IMtest
//
//  Created by xiaobo on 15/7/2.
//  Copyright © 2015年 xiaobo. All rights reserved.
//

import UIKit

class ConversationListViewController: RCConversationListViewController {
    
    let conVC = RCConversationViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        appDelegate?.connectServer({ () -> Void in
                        
            self.setDisplayConversationTypes([
                RCConversationType.ConversationType_APPSERVICE.rawValue,
                RCConversationType.ConversationType_CHATROOM.rawValue,
                RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,
                RCConversationType.ConversationType_DISCUSSION.rawValue,
                RCConversationType.ConversationType_GROUP.rawValue,
                RCConversationType.ConversationType_PRIVATE.rawValue,
                RCConversationType.ConversationType_PUBLICSERVICE.rawValue,
                RCConversationType.ConversationType_SYSTEM.rawValue
                
                ])
            
            self.refreshConversationTableViewIfNeeded()
        })
        

        // Do any additional setup after loading the view.
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destVC = segue.destinationViewController as? RCConversationViewController
        
        destVC?.targetId = self.conVC.targetId
        destVC?.userName = self.conVC.userName
        destVC?.conversationType = self.conVC.conversationType
        destVC?.title = conVC.title
        
        
        self.tabBarController?.tabBar.hidden = true
    }
    
 
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        
//        //代码跳转到会话界面
//        let conVC = RCConversationViewController()
//        
//        conVC.targetId = model.targetId
//        conVC.userName = model.conversationTitle
//        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
//        
//        conVC.title = model.conversationTitle
//        
//        self.navigationController?.pushViewController(conVC, animated: true)
//        
//        self.tabBarController?.tabBar.hidden = true
        
        
                conVC.targetId = model.targetId
                conVC.userName = model.conversationTitle
                conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        
                conVC.title = model.conversationTitle
        
        self.performSegueWithIdentifier("tapOnCell", sender: self)
        
    }



}
