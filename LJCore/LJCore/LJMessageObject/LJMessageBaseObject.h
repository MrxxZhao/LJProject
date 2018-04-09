//
//  LJMessageBaseObject.h
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJMessageBaseObject : NSObject

/**
 模块名称
 */
@property (nonatomic, copy, readonly) NSString * module;

/**
 方法名
 */
@property (nonatomic, copy, readonly) NSString * action;

/**
 参数
 */
@property (nonatomic, copy, readonly) NSDictionary * parameters;

/**
 回调ID
 */
@property (nonatomic, copy) NSString * identifier;

/**
 回调方法名
 */
@property (nonatomic, copy, readonly) NSString  *callbackFunction;

- (instancetype)int UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new __attribute__((unavailable("new方法不可用，请用javascriptModelWithDictionary:")));
/**
 返回一个JS Call Native 消息体

 @param dictionary JS入参
 @return 返回一个消息体
 */
+ (instancetype)javascriptModelWithDictionary:(NSDictionary *)dictionary;
@end
