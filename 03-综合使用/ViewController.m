//
//  ViewController.m
//  03-综合使用
//
//  Created by xiaomage on 15/5/25.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "XMGShop.h"
#import "XMGShopView.h"

@interface ViewController ()
/** 存放所有商品的整体 */
@property (weak, nonatomic) IBOutlet UIView *shopsView;

/** HUD */
@property (weak, nonatomic) IBOutlet UILabel *hud;

// 文档注释
/** 添加按钮 */
@property (weak, nonatomic) UIButton *addBtn;
/** 删除按钮 */
@property (weak, nonatomic) UIButton *removeBtn;

/** 全部商品数据 */
@property (strong, nonatomic) NSArray *shops;
@end

@implementation ViewController

// 加载plist数据（比较大）
// 懒加载：用到时再去加载，而且也只加载一次
- (NSArray *)shops
{
    if (_shops == nil) {
        // 加载一个字典数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"]];
        
        NSMutableArray *shopArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            XMGShop *shop = [XMGShop shopWithDict:dict];
            [shopArray addObject:shop];
        }
        _shops = shopArray;
    }
    return _shops;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shopsView.clipsToBounds = YES;
    
    // 添加“添加按钮”
    self.addBtn = [self addButtonWithImage:@"add" highImage:@"add_highlighted" disableImage:@"add_disabled" frame:CGRectMake(30, 30, 50, 50) action:@selector(add)];
    
    // 添加“删除按钮”
    self.removeBtn = [self addButtonWithImage:@"remove" highImage:@"remove_highlighted" disableImage:@"remove_disabled" frame:CGRectMake(270, 30, 50, 50) action:@selector(remove)];
    self.removeBtn.enabled = NO;
    
    // 加载xib文件
    // Test.xib --编译--> Test.nib
    // 方式1
//    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"Test" owner:nil options:nil];
//    [self.view addSubview:objs[1]];
    
    // 方式2
    // 一个UINib对象就代表一个xib文件
//    UINib *nib = [UINib nibWithNibName:@"Test" bundle:[NSBundle mainBundle]];
    // 一般情况下，bundle参数传nil，默认就是mainBundle
//    UINib *nib = [UINib nibWithNibName:@"Test" bundle:nil];
//    NSArray *objs = [nib instantiateWithOwner:nil options:nil];
//    [self.view addSubview:[objs lastObject]];
}

#pragma mark 添加按钮
- (UIButton *)addButtonWithImage:(NSString *)image highImage:(NSString *)highImage disableImage:(NSString *)disableImage frame:(CGRect)frame action:(SEL)action
{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置背景图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:disableImage] forState:UIControlStateDisabled];
    // 设置位置和尺寸
    btn.frame = frame;
    // 监听按钮点击
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    // 添加按钮
    [self.view addSubview:btn];
    return btn;
}

#pragma mark 添加
- (void)add
{
    // 每一个商品的尺寸
    CGFloat shopW = 80;
    CGFloat shopH = 90;
    
    // 一行的列数
    int cols = 3;
    
    // 每一列之间的间距
    CGFloat colMargin = (self.shopsView.frame.size.width - cols * shopW) / (cols - 1);
    // 每一行之间的间距
    CGFloat rowMargin = 10;
    
    // 商品的索引
    NSUInteger index = self.shopsView.subviews.count;
    
    // 创建一个父控件（整体：存放图片和文字）
    XMGShopView *shopView = [XMGShopView shopViewWithShop:self.shops[index]];
    
    // 商品的x值
    NSUInteger col = index % cols;
    CGFloat shopX = col * (shopW + colMargin);
    
    // 商品的y值
    NSUInteger row = index / cols;
    CGFloat shopY = row * (shopH + rowMargin);
    
    shopView.frame = CGRectMake(shopX, shopY, shopW, shopH);
    
    // 添加控件
    [self.shopsView addSubview:shopView];
    
    // 控制按钮的可用性
    [self checkState];
}



#pragma mark 删除
- (void)remove
{
    [[self.shopsView.subviews lastObject] removeFromSuperview];
    
    // 控制按钮的可用性
    [self checkState];
}





#pragma mark 检查状态：按钮状态
- (void)checkState
{
    // 删除按钮什么时候可以点击：商品个数 > 0
    self.removeBtn.enabled = (self.shopsView.subviews.count > 0);
    // 添加按钮什么时候可以点击：商品个数 < 总数
    self.addBtn.enabled = (self.shopsView.subviews.count < self.shops.count);
    
    // 显示HUD
    NSString *text = nil;
    if (self.removeBtn.enabled == NO) { // 删光了
        text = @"已经全部删除";
    } else if (self.addBtn.enabled == NO) { // 加满了
        text = @"已经添加满了";
    }
    if (text == nil) return;
    
    self.hud.text = text;
    self.hud.alpha = 1.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hud.alpha = 0.0;
    });
}

@end
