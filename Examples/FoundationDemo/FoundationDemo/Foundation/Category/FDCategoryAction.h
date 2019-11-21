//
//  FDCategoryAction.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/21.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDCategoryAction : TIRouterActionBase

PGMethod(methodCover, "fd://Foundation/Category/Method?c=分类方法将被编译源文件列表中最后编译的覆盖");

PGMethod(loadMethod, "fd://Foundation/Category/Load?c=先编译先调用、父类早于子类调用、类和分类加载时调用");
PGMethod(initializeMethod, "fd://Foundation/Category/initialize?c=objc_msgSend时调用");

@end

NS_ASSUME_NONNULL_END
