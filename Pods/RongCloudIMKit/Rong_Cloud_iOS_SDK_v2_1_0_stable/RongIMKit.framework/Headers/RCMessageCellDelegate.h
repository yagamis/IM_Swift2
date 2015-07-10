//
//  RCMessageCellDelegate.h
//  RongIMKit
//
//  Created by xugang on 3/14/15.
//  Copyright (c) 2015 RongCloud. All rights reserved.
//

#ifndef RongIMKit_RCMessageCellDelegate_h
#define RongIMKit_RCMessageCellDelegate_h

/**
 *  消息Cell事件回调
 */
@protocol RCMessageCellDelegate <NSObject>

@optional
;
/**
 *  点击消息内容
 *
 *  @param model 数据
 */
- (void)didTapMessageCell:(RCMessageModel *)model;

/**
 *  点击头像事件
 *
 *  @param userId 用户的ID
 */
- (void)didTapCellPortrait:(NSString *)userId;

/**
 *  长按消息内容
 *
 *  @param model 数据
 *  @param view 视图
 */
- (void)didLongTouchMessageCell:(RCMessageModel *)model inView:(UIView *)view;

/**
 * 点击消息发送失败视图事件
 *
 *  @param model 消息数据模型
 */
- (void)didTapmessageFailedStatusViewForResend:(RCMessageModel *)model;
@end

#endif
