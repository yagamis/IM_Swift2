/**
 * Copyright (c) 2014-2015, RongCloud.
 * All rights reserved.
 *
 * All the contents are the copyright of RongCloud Network Technology Co.Ltd.
 * Unless otherwise credited. http://rongcloud.cn
 *
 */

//  RCPublicServiceProfile.h
//  Created by litao on 15/4/9.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RCStatusDefine.h"
#import "RCPublicServiceMenu.h"

/**
 * 公众服务账号信息
 */
@interface RCPublicServiceProfile : NSObject
/*
 * 公众服务账号名称
 */
@property(nonatomic, strong) NSString *name;
/*
 * 公众服务账号描述
 */
@property(nonatomic, strong) NSString *descriptions;
/*
 * 公众服务账号的userID
 */
@property(nonatomic, strong) NSString *serviceId;
/*
 * 公众服务账号头像Url
 */
@property(nonatomic, strong) NSString *thumbnailUrl;
/*
 * 公众服务账号主体
 */
@property(nonatomic, strong) NSString *owner;
/*
 * 公众服务账号主体Url
 */
@property(nonatomic, strong) NSString *ownerUrl;
/*
 * 公众服务账号的电话号码
 */
@property(nonatomic, strong) NSString *serviceTel;
/*
 * 公众服务账号历史消息
 */
@property(nonatomic, strong) NSString *histroyMsgUrl;
/*
 * 公众服务账号地理位置
 */
@property(nonatomic, strong) CLLocation *location;
/*
 * 公众服务账号经营范围
 */
@property(nonatomic, strong) NSString *scope;
/*
 * 公众服务账号类型
 */
@property(nonatomic) RCPublicServiceType serviceType;
/*
 * 是否关注该公众服务账号
 */
@property(nonatomic) BOOL followed;
/*
 * extra信息
 */
@property(nonatomic, strong) NSString *extra;
/*
 * 公众服务账号菜单
 */
@property(nonatomic, strong) RCPublicServiceMenu *menu;
/*
 * 公众服务账号的全局属性
 */
@property(nonatomic, getter=isGlobal) BOOL global;

/**
 *  公众服务账号信息的json数据
 */
@property(nonatomic, strong) NSDictionary *jsonDict;
/**
 * 根据JSON 字典创建公众服务账号实体
 *
 * @param  jsonContent   存储公众服务账号属性的字典
 */
- (void)initContent:(NSString *)jsonContent;
@end
