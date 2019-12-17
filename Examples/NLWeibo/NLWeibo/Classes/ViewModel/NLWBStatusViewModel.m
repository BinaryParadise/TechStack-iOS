//
//  NLWBStatusViewModel.m
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLWBStatusViewModel.h"
#import <NLUIComponent/NLUIComponent.h>

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
        if (status.pic_urls.count > 1) {
            NSMutableArray *marr = [NSMutableArray array];
            [status.pic_urls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [marr addObject:[obj mc_stringForKey:@"thumbnail_pic"]];
            }];
            _picURLs = marr;
            CGFloat imgW = ceil((UIScreen.mainScreen.bounds.size.width - 16.0*2-8*2) /3.0);
            _picSize = CGSizeMake(imgW, imgW);
            switch (self.picURLs.count) {
                case 2:
                case 3:
                    _imageGroupSize = CGSizeMake(self.picURLs.count * (imgW+8)-8, imgW);
                    break;
                case 4:
                    _imageGroupSize = CGSizeMake(imgW*2+8, imgW*2+8);
                    break;
                case 5:
                case 6:
                    _imageGroupSize = CGSizeMake(3 * (imgW+8)-8, 2*imgW+2*8);
                    break;
                default:
                    _imageGroupSize = CGSizeMake(3 * (imgW+8)-8, 3*imgW+2*8);
                    break;
            }
        } else {
            _picURL = status.original_pic ? :status.thumbnail_pic;
            _picSize = CGSizeMake(288, 256);
            if (_picURL) {
                [UIImage remoteSize:_picURL completion:^(NSString * imgURL, CGSize size) {
                    if (!CGSizeEqualToSize(size, CGSizeZero)) {
                        self->_picSize = size;
                    }
                }];
            }
        }
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
