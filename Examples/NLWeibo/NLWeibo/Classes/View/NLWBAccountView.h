//
//  NLWBAccountView.h
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//

#import <UIKit/UIKit.h>
#import "WBAccountViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NLWBAccountViewDelegate <NSObject>

- (void)willClearAuthData;

@end

@interface NLWBAccountView : UIView

@property (nonatomic, weak) id<NLWBAccountViewDelegate> delegate;


- (void)fillWithViewModel:(WBAccountViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
