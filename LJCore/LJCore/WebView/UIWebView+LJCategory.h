//
//  UIWebView+LJCategory.h
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol LJWebViewDelegate <UIWebViewDelegate>

@optional

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)context;

@end
@interface UIWebView (LJCategory)

@property (nonatomic, readonly) JSContext *jsContext;

@end
