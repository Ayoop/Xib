//
//  XMGShop.h
//  03-综合使用
//
//  Created by xiaomage on 15/5/26.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  存放商品数据的模型

#import <Foundation/Foundation.h>

@interface XMGShop : NSObject
/** 商品名称 */
@property (nonatomic, strong) NSString *name;
/** 图标 */
@property (nonatomic, strong) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)shopWithDict:(NSDictionary *)dict;

@end
