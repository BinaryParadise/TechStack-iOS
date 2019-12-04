//
//  NLWBAccountViewController.h
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//


#import <NLUIComponent/NLViewController.h>
#import "../Presenter/NLWeiboPresenter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 账号管理
 */
@interface NLWBAccountViewController : NLViewController

@property (nonatomic, strong) NLWeiboPresenter *presenter;


@end

NS_ASSUME_NONNULL_END
