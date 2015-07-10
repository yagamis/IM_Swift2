//
//  RCConversationSettingTableViewHeader.h
//  RongIMToolkit
//
//  Created by Liv on 15/3/25.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCConversationSettingTableViewHeader;

/**
 *  RCConversationSettingTableViewHeaderDelegate
 */
@protocol RCConversationSettingTableViewHeaderDelegate <NSObject>

@optional
/**
 *  设置选中item的回调操作
 *
 *  @param settingTableViewHeader   settingTableViewHeader description
 *  @param indexPathForSelectedItem indexPathForSelectedItem description
 *  @param users users description
 */
- (void)settingTableViewHeader:(RCConversationSettingTableViewHeader *)settingTableViewHeader
       indexPathOfSelectedItem:(NSIndexPath *)indexPathOfSelectedItem
            allTheSeletedUsers:(NSArray *)users;

/**
 *  点击删除的回调
 *
 *  @param indexPath 点击索引
 */
- (void)deleteTipButtonClicked:(NSIndexPath *)indexPath;

@end

/**
 *  RCConversationSettingTableViewHeader
 */
@interface RCConversationSettingTableViewHeader
    : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/**
 *  showDeleteTip
 */
@property(nonatomic, assign) BOOL showDeleteTip;

/**
 *  isAllowedDeleteMember
 */
@property(nonatomic, assign) BOOL isAllowedDeleteMember;

/**
 *  call back
 */
@property(weak, nonatomic) id<RCConversationSettingTableViewHeaderDelegate> settingTableViewHeaderDelegate;
/**
 *  contains the RCUserInfo
 */
@property(strong, nonatomic) NSMutableArray *users;
@end
