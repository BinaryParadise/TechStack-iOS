//
//  GDControlActions.h
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface GDControlAction : TIRouterActionBase

+ (void)buttonAction:(PGRouterContext *)context PGTarget("gd://UIControl/UIButton");

+ (void)textFieldAction:(PGRouterContext *)context PGTarget("gd://UIControl/UITextField");

@end

NS_ASSUME_NONNULL_END
