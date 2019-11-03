//
//  FWBStatus.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWBUser.h"

@interface FWBStatus : FDBase

/**
 微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 微博ID
 */
@property (nonatomic, assign) long long sid;

/**
 微博MID
 */
@property (nonatomic, assign) long long mid;

/**
 字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/**
 微博来源
 */
@property (nonatomic, copy) NSString *source;

/**
 是否已收藏，true：是，false：否
 */
@property (nonatomic, assign) NSString *favorited;

/**
 是否被截断，true：是，false：否
 */
@property (nonatomic, assign) NSString *truncated;

/**
 （暂未支持）回复ID
 */
@property (nonatomic, copy) NSString *in_reply_to_status_id;

/**
 （暂未支持）回复人UID
 */
@property (nonatomic, copy) NSString *in_reply_to_user_id;

/**
 （暂未支持）回复人昵称
 */
@property (nonatomic, copy) NSString *in_reply_to_screen_name;

/**
 缩略图片地址，没有时不返回此字段
 */
@property (nonatomic, copy) NSString *thumbnail_pic;

/**
 中等尺寸图片地址，没有时不返回此字段
 */
@property (nonatomic, copy) NSString *bmiddle_pic;

/**
 原始图片地址，没有时不返回此字段
 */
@property (nonatomic, copy) NSString *original_pic;

/**
 地理信息字段 详细
 */
@property (nonatomic, copy) NSString *geo;

/**
 微博作者的用户信息字段 详细
 */
@property (nonatomic, strong) FWBUser *user;

/**
 被转发的原微博信息字段，当该微博为转发微博时返回 详细
 */
@property (nonatomic, copy) NSString *retweeted_status;

/**
 转发数
 */
@property (nonatomic, assign) NSInteger reposts_count;

/**
 评论数
 */
@property (nonatomic, assign) NSInteger comments_count;

/**
 表态数
 */
@property (nonatomic, assign) NSInteger attitudes_count;

/**
 暂未支持
 */
@property (nonatomic, assign) NSInteger mlevel;

/**
 微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 */
@property (nonatomic, copy) NSString *visible;

/**
 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 */
@property (nonatomic, copy) NSString *pic_ids;

/**
 微博流内的推广微博ID
 */
@property (nonatomic, copy) NSString *ad;

@end
