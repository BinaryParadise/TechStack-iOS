//
//  FDNSDate.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/7.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDNSDate : NSObject

@end

@interface NSDate (Extension)

- (NSString *)localTimeString;

@end
