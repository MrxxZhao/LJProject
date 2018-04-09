//
//  LJBase64Encode.m
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import "LJBase64Encode.h"

@implementation LJBase64Encode
+ (NSString *)base64_encode_data:(NSData *)data {
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSData *)base64_decode:(NSString *)str {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}
@end
