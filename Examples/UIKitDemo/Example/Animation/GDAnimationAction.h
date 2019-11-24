//
//  GDAnimationAction.h
//  UIKitDemo
//
//  Created by Rake Yang on 2019/6/15.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDAnimationAction : TIRouterActionBase

PGMethod(animationNormal, "ap://General/Animation/Normal?c=一般动画");
PGMethod(animationCustom, "ap://General/Animation/Custom?c=自定义动画&type=1");
PGMethod(animationKeyFrame, "ap://General/Animation/KeyFrame?c=关键帧动画&type=2");

@end

NS_ASSUME_NONNULL_END
