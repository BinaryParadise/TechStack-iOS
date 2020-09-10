//
//  NLNSDate.h
//  Neverland
//
//  Created by Rake Yang on 2019/11/7.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLNSDate : NSObject

@end

@interface NSDate (Extension)

- (NSString *)localTimeString;

/// 获取服务短时间（最优同步方案）
+ (instancetype)serverDate;

@end
