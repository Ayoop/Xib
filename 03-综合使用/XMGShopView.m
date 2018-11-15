//
//  XMGShopView.m
//  03-综合使用
//
//  Created by xiaomage on 15/5/28.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGShopView.h"
#import "XMGShop.h"
#import "XMGMyButton.h"
#import "XMGNameLabel.h"

@interface XMGShopView()
/** 图标 */
@property (weak, nonatomic) IBOutlet XMGMyButton *iconView;

/** 名字 */
@property (weak, nonatomic) IBOutlet XMGNameLabel *nameLabel;
@end

@implementation XMGShopView

+ (instancetype)shopView
{
    
    return [self shopViewWithShop:nil];
}

+ (instancetype)shopViewWithShop:(XMGShop *)shop
{
    XMGShopView *shopView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    shopView.shop = shop;
    return shopView;
}

- (void)setShop:(XMGShop *)shop
{
    _shop = shop;
    
    self.iconView.image = [UIImage imageNamed:shop.icon];

    self.nameLabel.text = shop.name;
}




@end
