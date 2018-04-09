//
//  LJWKWebViewJavascriptBridge.m
//  LJProject
//
//  Created by sf on 2018/3/29.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import "LJWKWebViewJavascriptBridge.h"

@interface LJWKWebViewJavascriptBridge ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>


@end

@implementation LJWKWebViewJavascriptBridge

- (void)setWebView:(WKWebView *)webView {
    _webView = webView;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
}
- (void)setUserContentController:(WKUserContentController *)userContentController {
    _userContentController = userContentController;
    [_userContentController addScriptMessageHandler:self  name:@"javascriptBridgeSync"];
}

#pragma mark - 回调处理
- (void)evalCallBackJavascriptForIdentifier:(NSString *)identifier withStatus:(NSString *)status withParameter:(id)parameter {
    NSString *evalString = [self convertCallBackJSONStringForIdentifier:identifier withStatus:status withParameter:parameter];
    if ([[NSThread currentThread] isMainThread]) {
        [self.webView evaluateJavaScript:evalString completionHandler:nil];
    } else {
        __strong typeof(self)strongSelf = self;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [strongSelf.webView evaluateJavaScript:evalString completionHandler:nil];
        });
    }
}

- (void)evalCallEventJavascriptForIdentifier:(NSString *)identifier withStatus:(NSString *)status withParameter:(id)parameter {
    NSString *evalString = [self convertCallEventJSONStringForIdentifier:identifier withStatus:status withParameter:parameter];
    if ([[NSThread currentThread] isMainThread]) {
        [self.webView evaluateJavaScript:evalString completionHandler:nil];
    } else {
        __strong typeof(self)strongSelf = self;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [strongSelf.webView evaluateJavaScript:evalString completionHandler:nil];
        });
    }
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"调用到异步方法  参数: %@ ",message.body);
    NSDictionary *dict = message.body;
    [self transferToNative:dict];
}
@end
