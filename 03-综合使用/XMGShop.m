//
//  XMGShop.m
//  03-综合使用
//
//  Created by xiaomage on 15/5/26.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGShop.h"

@implementation XMGShop
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (instancetype)shopWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
