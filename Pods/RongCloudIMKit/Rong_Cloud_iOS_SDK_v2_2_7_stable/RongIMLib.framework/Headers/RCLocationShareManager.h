//
//  RCLocationShareManager.h
//  RongIMLib
//
//  Created by litao on 15/7/14.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCIMClient.h"

#import <CoreLocation/CoreLocation.h>

/**
 @enum 网络连接状态码
 */
typedef NS_ENUM(NSInteger, RCLocationShareStatus) {
    RC_LOCATION_SHARE_STATUS_IDLE,
    RC_LOCATION_SHARE_STATUS_INCOMING,
    RC_LOCATION_SHARE_STATUS_OUTGOING,
    RC_LOCATION_SHARE_STATUS_CONNECTED
};

typedef NS_ENUM(NSInteger, RCLocationShareErrorCode) {
    RC_LOCATION_SHARE_NOT_SUPPORT,
    RC_LOCATION_SHARE_CONVERSATION_NOT_SUPPORT,
    RC_LOCATION_SHARE_EXCEED_MAX_PARTICIPANT,
    RC_LOCATION_SHARE_GET_CONVERSATION_FAILURE,
};

@protocol RCLocationShareObserver <NSObject>
@optional
- (void)onLocationShareStatusChange:(RCLocationShareStatus)status;
- (void)onReceiveLocation:(CLLocation *)location fromUserId:(NSString *)userId;
- (void)onParticipantsJoin:(NSString *)userId;
- (void)onParticipantsQuit:(NSString *)userId;
- (void)onFailUpdateLocation:(NSString *)description;
- (void)onLocationShareStartFailed:(long)messageId;
@end

@protocol RCLocationShareProxy <NSObject>
- (void)startLocationShare;
- (void)joinLocationShare;
- (void)quitLocationShare;
- (void)addLocationShareObserver:(id<RCLocationShareObserver>)delegate;
- (void)removeLocationShareObserver:(id<RCLocationShareObserver>)delegate;
- (NSArray *)getParticipants;
- (RCLocationShareStatus)getStatus;
- (CLLocation *)getLocation:(NSString *)userId;
@end



@interface RCLocationShareManager : NSObject
/**
 *  获取位置共享的核心类单例。
 *
 *  @return 取位置共享的核心类单例。
 */
+ (instancetype)sharedManager;

- (void)getLocationShareProxy:(RCConversationType)conversationType
                                         targetId:(NSString *)targetId
                                          success:(void (^)(id<RCLocationShareProxy> locationShare))successBlock
                                            error:(void (^)(RCLocationShareErrorCode status))errorBlock;

@end
