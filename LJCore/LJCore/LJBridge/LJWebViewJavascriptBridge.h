//
//  LJWebViewJavascriptBridge.h
//  LJProject
//
//  Created by sf on 2018/3/29.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJJavascriptBridge.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
@protocol LJJavascriptBridgeProtocol <JSExport>

/**
 JS Call Native  同步方法
 
 @param parameter JS传过来的参数
 */
- (id)javascriptBridgeSync:(JSValue *)parameter;


/**
 JS Call Native 异步方法
 
 @param parameter JS传过来的参数
 */
- (id)javascriptBridgeAsync:(JSValue *)parameter;

@end
@interface LJWebViewJavascriptBridge : LJJavascriptBridge<LJJavascriptBridgeProtocol>
/**
 webView实例
 */
@property (nonatomic, strong) UIWebView *webView;

/**
 JS执行上下文
 */
@property (nonatomic, strong) JSContext *context;

@end
