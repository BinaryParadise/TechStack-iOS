//
//  NSDictionary+ScriptNative.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/29.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ScriptNative)

- (NSString *)sn_stringForKey:(NSString *)key;
- (NSNumber *)sn_numberForKey:(NSString *)key;
- (BOOL)sn_boolForKey:(NSString *)key;
- (int)sn_intForKey:(NSString *)key;
- (long)sn_longForKey:(NSString *)key;
- (long long)sn_longlongForKey:(NSString *)key;
- (float)sn_floatForKey:(NSString *)key;
- (double)sn_doubleForKey:(NSString *)key;
- (NSArray *)sn_arrayForKey:(NSString *)key;
- (NSDictionary *)sn_dictionaryForKey:(NSString *)key;

@end
