//
//  XCMStatePrompt.h
//  状态栏指示器
//
//  Created by 奚超明 on 16/5/17.
//  Copyright © 2016年 奚超明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCMStatePrompt : NSObject

/**
 * 显示通用状态
 *  title : 显示的文字
 *  image : 配图
 */
+ (void)xcm_showStatePromptWithTitle:(NSString *)title image:(UIImage *)image;

/** 显示正在加载 */
+ (void)xcm_showStatePromptLoadingWithTitle:(NSString *)title;

/** 显示加载成功 */
+ (void)xcm_showStatePromptSuccessWithTitle:(NSString *)title;

/** 显示加载失败 */
+ (void)xcm_showStatePromptErrorWithTitle:(NSString *)title;

/** 隐藏状态栏提示 */
+ (void)xcm_hidden;

/** 修改背景颜色 */
+ (void)xcm_setStatePromptBackGroudColor:(UIColor *)color;

/** 修改字体颜色 */
+ (void)xcm_setStatePromptTitleColor:(UIColor *)color;

@end
