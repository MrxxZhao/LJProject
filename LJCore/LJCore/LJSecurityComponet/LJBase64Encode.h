//
//  LJBase64Encode.h
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBase64Encode : NSObject
+ (NSString *)base64_encode_data:(NSData *)data NS_AVAILABLE(10_9, 7_0);

+ (NSData *)base64_decode:(NSString *)str NS_AVAILABLE(10_9, 7_0);
@end
