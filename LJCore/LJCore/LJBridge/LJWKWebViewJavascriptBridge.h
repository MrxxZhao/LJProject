//
//  LJWKWebViewJavascriptBridge.h
//  LJProject
//
//  Created by sf on 2018/3/29.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "LJJavascriptBridge.h"
@interface LJWKWebViewJavascriptBridge : LJJavascriptBridge<LJJavascriptBridgeBaseProtocol>
/**
 webView实例
 */
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WKUserContentController *userContentController;

/**
 加工wkWebView
 
 @param rect <#rect description#>
 @return <#return value description#>
 */
- (WKWebView *)polishWKWebViewWithFrame:(CGRect)rect;
@end
