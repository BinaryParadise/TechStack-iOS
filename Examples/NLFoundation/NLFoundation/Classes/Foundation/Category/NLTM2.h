//
//  NLTM2.h
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
@interface NLTM2 : NSObject

- (NSInteger)hello;

@end

@interface NLTM2 (Extra1)

@end


@interface NLTM2 (Extra2)

@end

@interface FDTM2Child1 : NLTM2

@end

@interface FDTM2Child2 : FDTM2Child1

@end

NS_ASSUME_NONNULL_END
