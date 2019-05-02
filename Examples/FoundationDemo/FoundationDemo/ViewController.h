//
//  ViewController.h
//  FoundationDemo
//
//  Created by joengzi on 2019/1/31.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCDynamicAction/MCDynamicActionProtocol.h>
#import <MCDynamicAction/MCDynamicAction.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSArray<MCDynamicAction *> *marr;

@property (nonatomic, strong) id<MCDynamicActionProtocol> action;

@end

