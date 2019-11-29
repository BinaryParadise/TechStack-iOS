//
//  NSNumber+JSConvert.h
//  Neverland
//
//  Created by Rake Yang on 2019/2/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (JSConvert)

/**
 十进制化的字符串（保留精度）

 @return 字符串
 */
- (NSString *)decimalStringValue;

@end

NS_ASSUME_NONNULL_END
