//
//  RCLocationShareStartMessage.h
//  RongIMLib
//
//  Created by litao on 15/7/14.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
#define RCLocationShareStartMessageTypeIdentifier @"RC:LocStartMsg"
@interface RCLocationShareStartMessage : RCMessageContent
/** 
 * 消息内容 
 */
@property(nonatomic, strong) NSString *content;
/**
 *  附加信息
 */
@property(nonatomic, strong) NSString *extra;
/**
 *  根据参数创建消息对象
 *
 *  @param content  消息内容
 */
+ (instancetype)messageWithContent:(NSString *)content;
@end
