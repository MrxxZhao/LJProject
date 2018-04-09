//
//  LJWebViewJavascriptBridge.m
//  LJProject
//
//  Created by sf on 2018/3/29.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import "LJWebViewJavascriptBridge.h"
#import "UIWebView+LJCategory.h"
@interface LJWebViewJavascriptBridge ()<LJWebViewDelegate,UIWebViewDelegate>

@end

@implementation LJWebViewJavascriptBridge

- (void)setWebView:(UIWebView *)webView {
    _webView = webView;
    _webView.delegate = self;
}
#pragma mark - UIWebview应用场景同异步方法
- (id)javascriptBridgeSync:(JSValue *)parameter {
    @synchronized(self) {
        NSLog(@"调用到同步方法  参数: %@ ",parameter);
        NSString *dict = [parameter toString];
        [self transferToNative:dict];
    }
    return nil;
}

- (id)javascriptBridgeAsync:(JSValue *)parameter {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"调用到异步方法  参数: %@ ",parameter);
        NSString *dict = [parameter toString];
        [self transferToNative:dict];
    });
    return nil;
}
#pragma mark - LJWebViewDelegate
- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)context {
    self.context = context;
    context[@"XMF_Client"] = self;
}
#pragma mark - 回调处理
- (void)evalCallBackJavascriptForIdentifier:(NSString *)identifier withStatus:(NSString *)status withParameter:(id)parameter {
    NSString *evalString = [self convertCallBackJSONStringForIdentifier:identifier withStatus:status withParameter:parameter];
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"currentThread : %@",[NSThread currentThread]);
        [self.webView stringByEvaluatingJavaScriptFromString:evalString];
    }else {
        __strong typeof (self)strongSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"currentThread : %@",[NSThread currentThread]);
            [strongSelf.webView stringByEvaluatingJavaScriptFromString:evalString];
        });
    }
}

- (void)evalCallEventJavascriptForIdentifier:(NSString *)identifier withStatus:(NSString *)status withParameter:(id)parameter {
    NSString *evalString = [self convertCallEventJSONStringForIdentifier:identifier withStatus:status withParameter:parameter];
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"currentThread : %@",[NSThread currentThread]);
        [self.webView stringByEvaluatingJavaScriptFromString:evalString];
    }else {
        __strong typeof (self)strongSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"currentThread : %@",[NSThread currentThread]);
            [strongSelf.webView stringByEvaluatingJavaScriptFromString:evalString];
        });
    }
}
@end
