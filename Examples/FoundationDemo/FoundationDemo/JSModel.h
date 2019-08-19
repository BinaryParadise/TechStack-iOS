//
//  JSModel.h
//  FoundationDemo
//
//  Created by joengzi on 2019/2/19.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TIRouterAction/TIRouterAction.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSModel : NSObject

@property (nonatomic, copy) NSString *tag;

- (instancetype)initWithTag:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
