//
//  RCPublicServiceChatViewController.h
//  RongIMKit
//
//  Created by litao on 15/6/12.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCConversationViewController.h"


/**
 * 公众服务号会话VC
 *
 * 当初始化此类时，需要正确初始化基类，比如服务号ID，服务号类型，例如：
 * RCPublicServiceChatViewController *conversationVC = [[RCPublicServiceChatViewController alloc] init];
 * conversationVC.conversationType = conversationType;
 * conversationVC.targetId = targetId;
 * conversationVC.userName = conversationTitle;
 * conversationVC.title = conversationTitle;
 * [self.navigationController pushViewController:conversationVC animated:YES];
 */
@interface RCPublicServiceChatViewController : RCConversationViewController

@end
