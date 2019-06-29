//
//  NSDictionary+ScriptNative.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/29.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NSDictionary+ScriptNative.h"

@implementation NSDictionary (ScriptNative)

- (void)sn_valueForKey:(NSString *)key
                string:(void (^)(NSString *val))string
                number:(void (^)(NSNumber *val))number
                array:(void (^)(NSArray *val))array
                dictionary:(void (^)(NSDictionary *val))dictionary
                  null:(void (^)(NSString *val))null {
    if (key.length <= 0) {
        return;
    }
    id value = self[key];
    if ([value isKindOfClass:[NSString class]]) {
        string(value);
    } else if ([value isKindOfClass:[NSNumber class]]) {
        number(value);
    } else if ([value isKindOfClass:[NSArray class]]) {
        array(value);
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        dictionary(value);
    } else if ([value isKindOfClass:[NSNull class]]) {
        null(value);
    }
}

- (NSString *)sn_stringForKey:(NSString *)key {
    __block NSString *retValue;
    [self sn_valueForKey:key string:^(NSString *val) {
        retValue = val;
    } number:^(NSNumber *val) {
        retValue = val.stringValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (NSNumber *)sn_numberForKey:(NSString *)key {
    __block NSNumber *retValue;
    [self sn_valueForKey:key string:^(NSString *val) {
    } number:^(NSNumber *val) {
        retValue = val;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (int)sn_intForKey:(NSString *)key {
    __block int retValue;
    [self sn_valueForKey:key string:^(NSString *val) {
        retValue = val.intValue;
    } number:^(NSNumber *val) {
        retValue = val.intValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (long)sn_longForKey:(NSString *)key {
    return [self sn_longlongForKey:key];
}

- (long long)sn_longlongForKey:(NSString *)key {
    __block long retValue;
    [self sn_valueForKey:key string:^(NSString *val) {
        retValue = val.longLongValue;
    } number:^(NSNumber *val) {
        retValue = val.longLongValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (float)sn_floatForKey:(NSString *)key {
    __block float retValue;
    [self sn_valueForKey:key string:^(NSString *val) {
        retValue = val.floatValue;
    } number:^(NSNumber *val) {
        retValue = val.floatValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (double)sn_doubleForKey:(NSString *)key {
    __block double retValue;
    [self sn_valueForKey:key string:^(NSString *val) {
        retValue = val.doubleValue;
    } number:^(NSNumber *val) {
        retValue = val.doubleValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (NSArray *)sn_arrayForKey:(NSString *)key {
    __block NSArray *retValue;
    [self sn_valueForKey:key string:^(NSString *val) {
    } number:^(NSNumber *val) {
    } array:^(NSArray *val) {
        retValue = val;
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (NSDictionary *)sn_dictionaryForKey:(NSString *)key {
    __block NSDictionary *retValue;
    [self sn_valueForKey:key string:^(NSString *val) {
    } number:^(NSNumber *val) {
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        retValue = val;
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

@end
