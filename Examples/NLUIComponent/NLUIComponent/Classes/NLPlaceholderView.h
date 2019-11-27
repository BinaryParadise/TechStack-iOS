//
//  NLPlaceholderView.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/4.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCUIKit/UIColor+MCExtension.h>

/**
 占位视图：错误、重试、无数据等等
 */
@interface NLPlaceholderView : UIView

@property (nonatomic, copy) void (^onButtonClick)(void);

@end
