//
//  NLKeyValue.h
//  NLModelService
//
//  Created by Rake Yang on 2019/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLKeyValue : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) id value;

+ (instancetype)objectWithKey:(NSString *)key value:(id)value;

@end

NS_ASSUME_NONNULL_END
