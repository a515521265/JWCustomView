//
//  XCMStatePrompt.m
//  状态栏指示器
//
//  Created by 奚超明 on 16/5/17.
//  Copyright © 2016年 奚超明. All rights reserved.
//

#import "XCMStatePrompt.h"
#define kXCMFont [UIFont systemFontOfSize:12]

/** 状态栏显示时间 */
static CGFloat const XCMStateShowDuration = 2.5;

/** 状态栏消失时间 */
static CGFloat const XCMStateDismissDuration = 0.3;

/** 状态栏高度 */
static CGFloat const XCMStateHeight = 20;

@implementation XCMStatePrompt

/** 全局状态栏 */
static UIWindow *window_;

/** 全局定时器 */
static NSTimer *timer_;

/** 全局的背景颜色 */
static UIColor *backGroudColor_;

/** 全局的文字颜色 */
static UIColor *titleColor_;

/** 状态栏提示框 */
+ (void)showWindow
{
    CGFloat stateWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake(0, -XCMStateHeight, stateWidth, XCMStateHeight);
    
    // 显示前先隐藏
    window_.hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.frame = frame;
    if (backGroudColor_) {
        window_.backgroundColor = backGroudColor_;
    } else {
        window_.backgroundColor = [UIColor blackColor];
    }
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    
    frame.origin.y = 0;
    [UIView animateWithDuration:XCMStateDismissDuration animations:^{
        window_.frame = frame;
    }];
}

/**
 * 显示通用状态
 *  title : 显示的文字
 *  image : 配图
 */
+ (void)xcm_showStatePromptWithTitle:(NSString *)title image:(UIImage *)image
{
    // 停止定时器
    [timer_ invalidate];
    
    // 显示提示框
    [self showWindow];
    
    // 添加一个button，显示文字及配图
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = kXCMFont;
    if (titleColor_) {
        [button setTitleColor:titleColor_ forState:UIControlStateNormal];
    } else {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    // 如果有配图，则显示
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    button.frame = window_.bounds;
    [window_ addSubview:button];
    
    // 设置提示框显示一段时间后消失
    timer_ = [NSTimer scheduledTimerWithTimeInterval:XCMStateShowDuration target:self selector:@selector(xcm_hidden) userInfo:nil repeats:NO];
}

/** 显示正在加载 */
+ (void)xcm_showStatePromptLoadingWithTitle:(NSString *)title
{
    // 停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 显示提示框
    [self showWindow];
    
    // 文字提示
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:window_.bounds];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = kXCMFont;
    titleLabel.text = title;
    if (titleColor_) {
        titleLabel.textColor = titleColor_;
    } else {
        titleLabel.textColor = [UIColor whiteColor];
    }
    [window_ addSubview:titleLabel];
    
    // 添加加载提示图片
    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadView startAnimating];
    
    // 获得label中文字的宽度
    CGFloat labelWidth = [title sizeWithAttributes:@{NSFontAttributeName : kXCMFont}].width;
    CGFloat centerX = (window_.frame.size.width - labelWidth) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadView];
}

/** 显示加载成功 */
+ (void)xcm_showStatePromptSuccessWithTitle:(NSString *)title
{
    [self xcm_showStatePromptWithTitle:title image:[UIImage imageNamed:@"XCMStatePrompt.bundle/success"]];
}

/** 显示加载失败 */
+ (void)xcm_showStatePromptErrorWithTitle:(NSString *)title
{
    [self xcm_showStatePromptWithTitle:title image:[UIImage imageNamed:@"XCMStatePrompt.bundle/error"]];
}

/** 隐藏状态栏提示 */
+ (void)xcm_hidden
{
    [UIView animateWithDuration:XCMStateDismissDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = -XCMStateHeight;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        [timer_ invalidate];
        timer_ = nil;
    }];
}

/** 修改背景颜色 */
+ (void)xcm_setStatePromptBackGroudColor:(UIColor *)color
{
    backGroudColor_ = color;
}

/** 修改字体颜色 */
+ (void)xcm_setStatePromptTitleColor:(UIColor *)color
{
    titleColor_ = color;
}

@end
