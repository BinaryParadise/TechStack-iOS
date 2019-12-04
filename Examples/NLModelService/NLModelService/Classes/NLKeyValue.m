//
//  NLKeyValue.m
//  NLModelService
//
//  Created by Rake Yang on 2019/12/4.
//

#import "NLKeyValue.h"

@implementation NLKeyValue

+ (instancetype)objectWithKey:(NSString *)key value:(id)value {
    NLKeyValue *kv = [NLKeyValue new];
    kv.key = key;
    kv.value = value;
    return kv;
}
@end
