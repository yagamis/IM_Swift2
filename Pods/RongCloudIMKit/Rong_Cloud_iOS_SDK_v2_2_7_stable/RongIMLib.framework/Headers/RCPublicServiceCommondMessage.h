//
//  RCPublicServiceCommondMessage.h
//  RongIMLib
//
//  Created by litao on 15/6/23.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import "RCMessageContent.h"
#import "RCPublicServiceMenuItem.h"
#define RCPublicServiceCommandMessageTypeIdentifier @"RC:PSCmd"


/**
 * 该消息是用来在公众账号菜单请求信息使用。
 * 只能发送，接收不处理。
 * 不存储和计数
 */
@interface RCPublicServiceCommondMessage : RCMessageContent
/** 
 * 消息命令
 */
@property(nonatomic, strong) NSString *command;
/**
 * 消息内容
 */
@property(nonatomic, strong) NSString *data;
/**
 *  附加信息
 */
@property(nonatomic, strong) NSString *extra;

/**
 *  根据参数创建文本消息对象
 *
 *  @param item  公众账号菜单项
 */
+ (instancetype)messageFromMenuItem:(RCPublicServiceMenuItem *)item;
@end
