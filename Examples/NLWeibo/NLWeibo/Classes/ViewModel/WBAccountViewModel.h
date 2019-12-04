//
//  WBAccountViewModel.h
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//

#import <Foundation/Foundation.h>
#import <NLModelService/NLKeyValue.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBAccountViewModel : NSObject

@property (nonatomic, copy) NSArray<NLKeyValue *> *items;

- (instancetype)initWithAuthData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
