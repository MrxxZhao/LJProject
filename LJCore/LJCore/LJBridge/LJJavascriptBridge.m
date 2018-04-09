//
//  LJJavascriptBridge.m
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import "LJJavascriptBridge.h"
#import "LJBase64Encode.h"
#import "LJCodeDefine.h"
NSString* const LJ_Run_callBack = @"xmf.run.callBack('%@')";

NSString* const LJ_Run_callChange = @"xmf.run.callChange('%@')";

@interface LJJavascriptBridge ()


@end

static LJJavascriptBridge *bridge = nil;
@implementation LJJavascriptBridge

- (instancetype)init {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            bridge = [super init];
            bridge.handlerMap = [[NSMutableDictionary alloc] init];
        });
    return bridge;
}

- (NSDictionary *)configDictionary {
    if (!_configDictionary) {
//        _configDictionary = [NSDictionary dictionary];
        _configDictionary = @{@"scheme":DEFAULTSCHEME,@"host":DEFAULTHOST};
    }
    return _configDictionary;
}
#pragma mark - LJJavascriptBridgeBaseProtocol
#pragma mark - 注册方法到JS侧
- (void)registerModule:(NSString *)moduleName Action:(NSString *)actionName handler:(JSCallNativeHandler)handler {
    if (moduleName && actionName && handler) {
        NSMutableDictionary *handlerDic = [self.handlerMap objectForKey:moduleName];
        if (!handlerDic) {
            handlerDic = [[NSMutableDictionary alloc]init];
        }
        [self.handlerMap setObject:handlerDic forKey:moduleName];
        [handlerDic setObject:handler forKey:actionName];
    }
}
- (void)removeHandler:(NSString *)moduleName {
    if (moduleName) {
        [self.handlerMap removeObjectForKey:moduleName];
    }
}

#pragma mark - 数据处理转发到原生
- (void)transferToNative:(NSString *)parameterString {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[parameterString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    if (dict) {
//        NSLog(@"%@",[jsData objectForKey:@"target"]);
//        LJMessageBaseObject *msg = [LJMessageBaseObject initWithDictionary:[jsData objectForKey:@"target"]];
//        NSDictionary *handlerDic = [self.handlerMap objectForKey:msg.module];
//        JSCallNativeHandler handler= [handlerDic objectForKey:msg.action];
//        handler(msg);
    }
}

- (NSString *)convertCallBackJSONStringForIdentifier:(NSString *)identifier withStatus:(NSString *)status withParameter:(id)parameter {
    if (parameter) {
        NSMutableDictionary *jsDictionary = [NSMutableDictionary dictionary];
        [jsDictionary setObject:parameter forKey:@"data"];
        [jsDictionary setObject:[self headerDictionaryForStatus:status] forKey:@"header"];
        [jsDictionary setObject:self.configDictionary forKey:@"config"];
        NSString *string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
//        string =  [self transcodingJavascriptMessage:string];
        NSString *callBackParameterStr = [LJBase64Encode base64_encode_data:[string dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *evalString = [NSString stringWithFormat:LJ_Run_callBack,callBackParameterStr];
        return evalString;
    }
    return nil;
}
- (NSString *)convertCallEventJSONStringForIdentifier:(NSString *)identifier withStatus:(NSString *)status withParameter:(id)parameter {
    if (parameter) {
        NSMutableDictionary *jsDictionary = [NSMutableDictionary dictionary];
        [jsDictionary setObject:parameter forKey:@"data"];
        [jsDictionary setObject:[self headerDictionaryForStatus:status] forKey:@"header"];
        [jsDictionary setObject:self.configDictionary forKey:@"config"];
        NSString *string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsDictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        //        string =  [self transcodingJavascriptMessage:string];
        NSString *callBackParameterStr = [LJBase64Encode base64_encode_data:[string dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *evalString = [NSString stringWithFormat:LJ_Run_callBack,callBackParameterStr];
        return evalString;
    }
    return nil;
}
- (NSDictionary *)headerDictionaryForStatus:(nonnull NSString *)status {
    NSMutableDictionary *headerDictionary = [NSMutableDictionary dictionary];
    [headerDictionary setObject:status forKey:@"status"];
//    if (![XMFCommonUtil isNilOrEmpty:message]) {
//    [headerDictionary setObject:message forKey:@"message"];
//    }
    return [headerDictionary copy];
}
- (NSString *)transcodingJavascriptMessage:(NSString *)message {
    message = [message stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    message = [message stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    message = [message stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
    message = [message stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    message = [message stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    message = [message stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    message = [message stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    message = [message stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    return message;
}

- (BOOL)querySchemeAndHostValidate:(NSString*)scheme withHost:(NSString*)host {
    NSDictionary *defaultConfiguration = @{SCHEMENAME:DEFAULTSCHEME,HOSTNAME:DEFAULTHOST};
    NSArray *listConfiguration = [NSArray arrayWithObject:defaultConfiguration];
//    if (self.configDictionary && [self.configDictionary respondsToSelector:@selector(listSchemeAndHostConfiguration)]) {
//        listConfiguration = [self.configDictionary listSchemeAndHostConfiguration];
//    }
    BOOL validateResult = NO;
    for (NSDictionary *tempDictionary in listConfiguration) {
        if ([[tempDictionary objectForKey:@"/SchemeName"] isEqualToString:scheme] && [[tempDictionary objectForKey:@"/HostName" ] isEqualToString:host]) {
            validateResult = YES;
        }
    }
    return validateResult;
}
@end
