//
//  FDTM2.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/22.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 initialize调用演示
 */
@interface FDTM2 : NSObject

- (NSInteger)hello;

@end

@interface FDTM2 (Extra1)

@end


@interface FDTM2 (Extra2)

@end

@interface FDTM2Child1 : FDTM2

@end

@interface FDTM2Child2 : FDTM2Child1

@end

NS_ASSUME_NONNULL_END
