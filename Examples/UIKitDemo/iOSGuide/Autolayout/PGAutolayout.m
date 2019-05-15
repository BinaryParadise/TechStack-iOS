//
//  PGAutolayout.m
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/15.
//  Copyright © 2019 joengzi. All rights reserved.
//

#import "PGAutoLayout.h"
#import <UIKit/UIKit.h>

@implementation PGAutoLayout

+ (void)textField:(NSDictionary *)dict PG_Target("gd://UIControl/UITextField") {

}

+ (void)scrollView:(NSDictionary *)dict PG_Target("gd://UIView/UIScrollView") {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AutoLayout" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vc animated:YES];
}

@end
