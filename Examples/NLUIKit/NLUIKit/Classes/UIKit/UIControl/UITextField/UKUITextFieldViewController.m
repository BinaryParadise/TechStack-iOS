//
//  UKUITextFieldViewController.m
//  iOSGuide
//
//  Created by joengzi on 2019/3/15.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "UKUITextFieldViewController.h"

@interface UKUITextFieldViewController ()

@property (nonatomic, strong) UITextField *textField;
@end

@implementation UKUITextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)changeKeyboard:(id)sender {
    UIKeyboardType kt = self.textField.keyboardType;
    if (kt == UIKeyboardTypeWebSearch-1) {
        kt = UIKeyboardTypeDefault;
    } else {
        kt++;
    }
    self.textField.keyboardType = kt;
    //重新加载，键盘类型才会改变
    [self.textField reloadInputViews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
