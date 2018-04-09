//
//  ConfigurationProtocol.h
//  XMFCore
//
//  Created by 半饱 on 16/1/19.
//  Copyright © 2016年 半饱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol LJWebViewConfigurationProtocol <NSObject>

@optional

/**
 *  @author 半    饱, 16-01-19
 *
 *  @brief 是否打印WebView方法日志
 *
 *  @return 返回bool类型值，默认不打印
 */
- (BOOL)printWebViewMethodLog;
/**
 *  @author 半    饱, 16-01-19
 *
 *  @brief 是否打印WebView代理日志
 *
 *  @return 返回bool类型值，默认不打印
 */
- (BOOL)printWebViewDelegateLog;
/**
 *  @author 半    饱, 16-01-29
 *
 *  @brief 加载时是否使用缓存
 *
 *  @return 返回是否使用缓存，如果不实现则默认为：NO,否则返回设定的值
 */
- (BOOL)webViewLoadUseCache;
/**
 *  @author 半    饱, 16-01-29
 *
 *  @brief 使用那一种缓存机制
 *
 *  @return 返回设定的返回值
 */
- (NSURLRequestCachePolicy)webViewRequestCachePolicy NS_DEPRECATED_IOS(2_0, 6_0, "目前已采用XMF框架内置缓存结构，此方法设置无效!") ;
/**
 *  @author 半    饱, 16-01-21
 *
 *  @brief 控制加载页面的协议与主机名
 *
 *  @param webView
 *
 *  @return 返回配置列表，每一项都是一个NSDictionary，字典中有两个字段协议名/主机地址（域名）
 */
- (NSArray *)listSchemeAndHostConfiguration;
/*!
 *  @author 半    饱
 *
 *  @brief 错误页面加载地址
 *
 *  @param webView 加载的webView
 *
 *  @since V1.0
 */
- (void)errorPageLoad:(UIWebView *)webView;

/**
 设置内存缓存大小

 @return 返回M的数值，如：40 就是设置内存为4M。默认为：40M
 */
- (NSInteger)memoryCacheSize;

/**
 设置硬盘缓存大小

 @return 返回M的数值 ，如： 20 就是设置硬盘缓存为200M 。默认为：200M
 */
- (NSInteger)diskCacheSize;

/**
 在末认证的情况下，是否可以加载页面资源

 @return YES可以加载，NO不可以加载。设置成NO时，缓存不能正常启用。
 */
- (BOOL)loadPageResource;

/**
 是否开启多页面

 @return YES则开启多页面，NO为单个JSCore.默认为不开启多页面JSCore;
 */
- (BOOL)supportMutableWebView;
@end

