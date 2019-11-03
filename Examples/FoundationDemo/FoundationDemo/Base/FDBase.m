//
//  FDBase.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "FDBase.h"
#import <MCJSONKit/MCJSONKit.h>

@implementation FDBase

@end

@implementation FDBase (JSONModel)

+ (instancetype)fd_objectFromKeyValues:(id)keyValues {
    return [self mc_objectFromKeyValues:keyValues];
}

+ (NSArray *)fd_arrayOfModelsFromKeyValues:(id)keyValues {
    return [self mc_arrayOfModelsFromKeyValues:keyValues];
}

- (NSDictionary *)df_toDictionary {
    return [self mc_toDictionary];
}
- (NSString *)fd_JSONString {
    return [self mc_JSONString];
}

- (NSSet *)mc_allowedPropertiesSet {
    return [self fd_allowedPropertiesSet];
}

- (NSSet *)mc_ignorePropertiesSet {
    return [self fd_ignorePropertiesSet];
}

- (NSDictionary *)mc_keyMappingDictionary {
    return [self fd_keyMappingDictionary];
}

- (NSDictionary *)mc_typeMappingDictionary {
    return [self fd_typeMappingDictionary];
}

- (NSSet *)fd_allowedPropertiesSet {
    return nil;
}

- (NSSet *)fd_ignorePropertiesSet {
    return nil;
}

/**
 key关联字段
 
 @return key:对象属性 value:keyPath
 */
- (NSDictionary *)fd_keyMappingDictionary {
    return nil;
}

/**
 类型关联字典
 
 @return key:对象属性   value:类型class
 */
- (NSDictionary *)fd_typeMappingDictionary {
    return nil;
}

@end
