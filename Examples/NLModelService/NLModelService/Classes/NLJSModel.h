//
//  NLJSModel.h
//  Neverland
//
//  Created by Rake Yang on 2019/2/19.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLJSModel : NSObject

@property (nonatomic, copy) NSString *tag;

- (instancetype)initWithTag:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
