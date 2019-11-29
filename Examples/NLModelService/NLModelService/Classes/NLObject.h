//
//  NLObject.h
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MCFoundation/MCFoundation.h>
#import <NLUtility/NLNSDate.h>

NS_ASSUME_NONNULL_BEGIN

/**
 基础对象
 */
@interface NLObject : NSObject

@end

@interface NLObject (JSONModel)

/**
 通过字典创建模型
 
 @param keyValues 许可类型<NSData,NSDictionary,NSString>
 @return 新创建模型对象
 */
+ (instancetype)fd_objectFromKeyValues:(id)keyValues;

/**
 通过字典数组来创建一个模型数组
 @param keyValues 许可类型<NSData,NSArray,NSString>
 */
+ (NSArray *)fd_arrayOfModelsFromKeyValues:(id)keyValues;

- (NSDictionary *)df_toDictionary;
- (NSString *)fd_JSONString;

/**
 允许的属性集合，重写后则mc_ignorePropertiesSet失效
 */
- (NSSet *)fd_allowedPropertiesSet;

/**
 忽略的属性集合
 */
- (NSSet *)fd_ignorePropertiesSet;

/**
 key关联字段
 
 @return key:对象属性 value:keyPath
 */
- (NSDictionary *)fd_keyMappingDictionary;

/**
 类型关联字典
 
 @return key:对象属性   value:类型class
 */
- (NSDictionary *)fd_typeMappingDictionary;

- (id)fd_newValueFromOldValue:(id)oldValue property:(id)property;

@end

NS_ASSUME_NONNULL_END
