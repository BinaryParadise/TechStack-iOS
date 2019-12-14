//
//  UIImage+Size.h
//  NLUIComponent
//
//  Created by Rake Yang on 2019/12/14.
//

#import <UIKit/UIKit.h>

extern CGSize adjustSizeWithLimit(CGSize origin, CGSize limit);

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Size)

/**
 远程读取图片尺寸【最小读取】

 @param imgURL 地址
 @param completion 回调
 */
+ (void)remoteSize:(NSString *)imgURL completion:(void (^)(NSString * imgURL,CGSize size))completion;

@end

NS_ASSUME_NONNULL_END
