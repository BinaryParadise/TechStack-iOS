//
//  NSMutableArray+JSSafety.h
//  Neverland
//
//  Created by Rake Yang on 2019/2/2.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType> (JSSafety)

- (ObjectType)js_objectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
