//
//  UIWebView+LJCategory.m
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import "UIWebView+LJCategory.h"
#import <objc/runtime.h>

static const char LJJavaScriptContext[] = "LJJSContext";

static NSHashTable* LJ_WebViews = nil;

@interface UIWebView(LJCategories_Private)
- (void)didCreateJavaScriptContext:(JSContext *)context;
@end

@protocol LJWebFrame <NSObject>
- (id)parentFrame;
@end

@implementation NSObject(LJCategories)

- (void)webView:(id)unused didCreateJavaScriptContext:(JSContext *)context forFrame:(id<LJWebFrame>) frame {
    NSParameterAssert( [frame respondsToSelector: @selector( parentFrame )] );
    if ( [frame respondsToSelector: @selector( parentFrame) ] && [frame parentFrame] != nil )
        return;
    
    void (^notifyDidCreateJavaScriptContext)() = ^{
        for ( UIWebView *webView in LJ_WebViews ) {
            NSString *cookie = [NSString stringWithFormat: @"LJWebView_%lud", (unsigned long)webView.hash ];
            [webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat: @"var %@ = '%@'", cookie, cookie ]];
            if ( [context[cookie].toString isEqualToString:cookie] ) {
                [webView didCreateJavaScriptContext:context];
                return;
            }
        }
    };
    
    if ( [NSThread isMainThread] ) {
        notifyDidCreateJavaScriptContext();
    }
    else {
        dispatch_async( dispatch_get_main_queue(), notifyDidCreateJavaScriptContext );
    }
}
@end


@implementation UIWebView (LJCategories)

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LJ_WebViews = [NSHashTable weakObjectsHashTable];
    });
    NSAssert([NSThread isMainThread], @"uh oh - why aren't we on the main thread?");
    id webView = [super allocWithZone: zone];
    [LJ_WebViews addObject: webView];
    return webView;
}

- (void)didCreateJavaScriptContext:(JSContext *)context {
    [self willChangeValueForKey: @"LJJavaScriptContext"];
    objc_setAssociatedObject( self, LJJavaScriptContext, context, OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey: @"LJJavaScriptContext"];
    if ([self.delegate respondsToSelector: @selector(webView:didCreateJavaScriptContext:)]) {
        id<LJWebViewDelegate> delegate = ( id<LJWebViewDelegate>)self.delegate;
        [delegate webView: self didCreateJavaScriptContext:context];
    }
}

- (JSContext *)jsContext {
    JSContext *javaScriptContext = objc_getAssociatedObject(self, LJJavaScriptContext);
    return javaScriptContext;
}
@end
