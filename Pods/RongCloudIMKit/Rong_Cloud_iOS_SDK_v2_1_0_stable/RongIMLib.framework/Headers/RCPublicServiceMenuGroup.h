/**
 * Copyright (c) 2014-2015, RongCloud.
 * All rights reserved.
 *
 * All the contents are the copyright of RongCloud Network Technology Co.Ltd.
 * Unless otherwise credited. http://rongcloud.cn
 *
 */

//  RCPublicServiceMenuGroup.h
//  Created by litao on 15/4/14.

#import <Foundation/Foundation.h>

/**
 * 公众服务账号菜单组类
 */
@interface RCPublicServiceMenuGroup : NSObject
/**
 * 菜单组名称
 */
@property(nonatomic, strong) NSString *title;
/**
 * 菜单条目
 * 类型为RCPublicServiceMenuItem
 */
@property(nonatomic, strong) NSArray *menuItems; // of RCPublicServiceMenuItem
                                                 /**
                                                  * 根据JSON 字典创建菜单组实体
                                                  * @param  jsonDic    存储菜单组属性的字典
                                                  * @return 返回对象实例
                                                  */
+ (instancetype)menuGroupFromJsonDic:(NSDictionary *)jsonDic;
@end
