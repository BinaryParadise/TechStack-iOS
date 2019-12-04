//
//  NLWBStatusViewModel.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLWBStatusViewModel.h"

@interface NLWBStatusViewModel ()

@property (nonatomic, strong) NLFWBStatus *status;

@end

@implementation NLWBStatusViewModel

- (long long)maxId {
    return self.status.mid;
}

- (instancetype)initWithStatus:(NLFWBStatus *)status {
    if (self = [super init]) {
        _status = status;
        _avatar = status.user.avatar_large;
        _screen_name = status.user.screen_name;
        _createdStr = status.created_at.localTimeString;
        _source = status.source;
        _text = status.text;
    }
    return self;
}

+ (NSArray *)arrayWithStatuses:(NSArray<NLFWBStatus *> *)statuses {
    NSMutableArray *marr = [NSMutableArray array];
    [statuses enumerateObjectsUsingBlock:^(NLFWBStatus * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addObject:[[NLWBStatusViewModel alloc] initWithStatus:obj]];
    }];
    return marr;
}

@end
