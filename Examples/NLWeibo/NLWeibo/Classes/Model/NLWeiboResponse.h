//
//  NLWeiboResponse.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface NLWeiboResponse : NLBase

@property(nonatomic, copy) NSArray *advertises;
@property(nonatomic, copy) NSArray *ad;
@property(nonatomic, assign) BOOL hasvisible;
@property(nonatomic, assign) long long previous_cursor;
@property(nonatomic, assign) long long next_cursor;
@property(nonatomic, copy) NSString *previous_cursor_str;
@property(nonatomic, copy) NSString *next_cursor_str;
@property(nonatomic, assign) long total_number;
@property(nonatomic, assign) long interval;
@property(nonatomic, assign) long uve_blank;
@property(nonatomic, assign) long since_id;
@property(nonatomic, copy) NSString *since_id_str;
@property(nonatomic, assign) long max_id;
@property(nonatomic, copy) NSString *max_id_str;
@property(nonatomic, assign) long has_unread;

@end

NS_ASSUME_NONNULL_END
