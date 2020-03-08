//
//  GDGeneralAction.h
//  UIKitDemo
//
//  Created by Rake Yang on 2019/10/9.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <NLRouterAction/NLRouterActionBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDGeneralAction : NLRouterActionBase

PGMethod(signInWithApple, "UIKit://General/SignInWithApple?c=使用苹果登录")

PGMethod(darkMode, "UIKit://General/DarkMode?c=黑暗模式")

PGMethod(fontFamily, "UIKit://General/FontFamilys?c=所有字体")

@end

NS_ASSUME_NONNULL_END
