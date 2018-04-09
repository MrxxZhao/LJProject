//
//  LJJavascriptBridgeProtocol.h
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "LJMessageBaseObject.h"

typedef void(^JSCallNativeHandler)(LJMessageBaseObject *messageObject);
/**
 Bridge对象需要实现的方法
 */
@protocol LJJavascriptBridgeBaseProtocol <NSObject>
/**
 给JS侧注入原生的模块方法
 
 @param moduleName 模块名称
 @param actionName 方法名
 @param handler JS调用到Native之后执行的block
 */
- (void)registerModule:(NSString *)moduleName Action:(NSString *)actionName handler:(JSCallNativeHandler)handler;
/**
 Native回调JS,单次回调
 
 @param identifier 此次调用的唯一标识
 @param status 约定的处理结果状态
 @param parameter 回调的参数
 */
- (void)evalCallBackJavascriptForIdentifier:(NSString *)identifier withStatus:(NSString *)status  withParameter:(id)parameter;

/**
 Native回调JS,可多次回调,JS不释放
 
 @param identifier 此次调用的唯一标识
 @param status 约定的处理结果状态
 @param parameter 回调的参数
 */
- (void)evalCallEventJavascriptForIdentifier:(NSString *)identifier withStatus:(NSString *)status  withParameter:(id)parameter;

/**
 将单次回调CallBack的数据转化为字符串
 
 @param identifier 此次调用的唯一标识
 @param status 约定的处理结果状态
 @param parameter 回调的参数
 @return 返回JSON数据转化的字符串
 */
- (NSString *)convertCallBackJSONStringForIdentifier:(NSString *)identifier withStatus:(NSString *)status withParameter:(id)parameter;
/**
 将多次回调CallEven的数据转化为字符串
 
 @param identifier 此次调用的唯一标识
 @param status 约定的处理结果状态
 @param parameter 回调的参数
 @return 返回JSON数据转化的字符串
 */
- (NSString *)convertCallEventJSONStringForIdentifier:(NSString *)identifier withStatus:(NSString *)status withParameter:(id)parameter;
@end

