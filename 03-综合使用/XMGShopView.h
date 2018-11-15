//
//  XMGShopView.h
//  03-综合使用
//
//  Created by xiaomage on 15/5/28.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGShop;

@interface XMGShopView : UIView
/** 模型数据 */
@property (nonatomic, strong) XMGShop *shop;

+ (instancetype)shopView;
+ (instancetype)shopViewWithShop:(XMGShop *)shop;

// 接口的设计
// 接口：提供给外界的方法、属性等工具

//+ (NSString *)xibName;
@end
