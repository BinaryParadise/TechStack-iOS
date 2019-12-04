//
//  WBAccountViewModel.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//

#import "WBAccountViewModel.h"
#import <NLUtility/NLUtility.h>

@implementation WBAccountViewModel

- (instancetype)initWithAuthData:(NSDictionary *)data {
    if (self = [super init]) {
        NSMutableArray *marr = [NSMutableArray array];
        [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            id value = obj;
            if ([key hasSuffix:@"_in"]) {
               value = [[NSDate dateWithTimeIntervalSinceNow:[value doubleValue]/1000.0] localTimeString];
            }
            [marr addObject:[NLKeyValue objectWithKey:key value:value]];
        }];
        self.items = marr;
    }
    return self;
}

@end
