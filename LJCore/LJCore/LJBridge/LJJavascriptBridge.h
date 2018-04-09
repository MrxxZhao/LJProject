//
//  LJJavascriptBridge.h
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJMessageBaseObject.h"
#import "LJJavascriptBridgeBaseProtocol.h"
#import "LJWebViewConfigurationProtocol.h"
@interface LJJavascriptBridge : NSObject<LJJavascriptBridgeBaseProtocol>

/**
 用来存放注册的block
 */
@property (nonatomic, strong) NSMutableDictionary *handlerMap;

@property (nonatomic,strong) NSDictionary *configDictionary;

- (void)transferToNative:(NSString *)parameterString;

@end
