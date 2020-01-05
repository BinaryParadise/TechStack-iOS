//
//  GDControlActions.h
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface GDControlAction : NLRouterActionBase

PGMethod(buttonAction, "gd://UIControl/UIButton")

PGMethod(textFieldAction, "gd://UIControl/UITextField")

@end

NS_ASSUME_NONNULL_END
