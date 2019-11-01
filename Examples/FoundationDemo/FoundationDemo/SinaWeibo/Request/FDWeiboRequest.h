//
//  FDWeiboRequest.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FDActionCompletion)(BOOL success, id _Nullable data, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface FDWeiboRequest : NSObject

+ (void)getDataWithURL:(NSString *)url params:(NSDictionary * _Nullable)params completion:(FDActionCompletion)completion;

@end

NS_ASSUME_NONNULL_END
