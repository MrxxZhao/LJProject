//
//  LJMessageBaseObject.m
//  LJProject
//
//  Created by sf on 2018/3/28.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import "LJMessageBaseObject.h"
#import <objc/runtime.h>
@implementation LJMessageBaseObject
+ (instancetype)javascriptModelWithDictionary:(NSDictionary *)dictionary {
    LJMessageBaseObject *baseModel = [[self alloc] init];
    baseModel.identifier = dictionary[@"identifier"];
    return baseModel;
}

+ (NSArray *)propertyOfSelf {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([super class], &count);
    NSMutableArray *properNames =[NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [name substringFromIndex:1];
        [properNames addObject:key];
    }
    return [properNames copy];
}
@end
