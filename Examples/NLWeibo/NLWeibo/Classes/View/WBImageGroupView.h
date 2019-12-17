//
//  WBImageGroupView.h
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 图片分组视图【九宫格】
 */
@interface WBImageGroupView : UIView

@property (nonatomic, assign) CGSize imageSize;

- (void)fillWithImageURLs:(NSArray<NSString *> *)imageURLs;

@end

NS_ASSUME_NONNULL_END
