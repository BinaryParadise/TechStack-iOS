//
//  NLWBStatusViewModel.h
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Model/NLFWBStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface NLWBStatusViewModel : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *createdStr;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign, readonly) long long maxId;

- (instancetype)initWithStatus:(NLFWBStatus *)status;

+ (NSArray *)arrayWithStatuses:(NSArray<NLFWBStatus *> *)statuses;

@end

NS_ASSUME_NONNULL_END
