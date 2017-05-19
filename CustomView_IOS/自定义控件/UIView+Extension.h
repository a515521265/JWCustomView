//
//  UIView+Extension.h
//  JWKit
//
//  Created by 薄睿杰 on 16/6/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat          x;
@property (nonatomic, assign) CGFloat          y;
@property (nonatomic, assign) CGFloat          centerX;
@property (nonatomic, assign) CGFloat          centerY;
@property (nonatomic, assign) CGFloat          width;
@property (nonatomic, assign) CGFloat          height;
@property (nonatomic, assign) CGSize           size;
@property (nonatomic, assign) CGPoint          origin;
//距左边间距
-(UIView *(^)(CGFloat))left;
//距右边间距
-(UIView *(^)(CGFloat))right;
//距顶部距离
-(UIView *(^)(CGFloat))top;
//距底部距离
-(UIView *(^)(CGFloat))bottom;
//居中显示
-(UIView *(^)())setCenter;
//设置view大小
-(UIView *(^)(CGSize))setSize;

-(CGRect (^)(UIView *))getRelativewindowFrame;

- (void)addSingleTapEvent:(void(^)())event;

-(void)addlongTapEvent:(void(^)())event;

-(void)removeAllSubviews;

-(void)setViewHidden;

-(UIViewController *)getController;
/**
 *  添加弹性动画
 */
/**
 *  Make view draggable.
 *
 *  @param view    Animator reference view, usually is super view.
 *  @param damping Value from 0.0 to 1.0. 0.0 is the least oscillation. default is 0.4.
 */
- (void)makeDraggable;
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping;

/**
 *  Disable view draggable.
 */
- (void)removeDraggable;

/**
 *  If you call make draggable method in the initialize method such as `-initWithFrame:`,
 *  `-viewDidLoad`, the view may not be layout correctly at that time. So you should
 *  update snap point in `-layoutSubviews` or `-viewDidLayoutSubviews`.
 *
 *  By the way, you can call make draggable method in `-layoutSubviews` or
 *  `-viewDidLayoutSubviews` directly instead of update snap point.
 */
- (void)updateSnapPoint;


#pragma mark ------<查找特定类型的subview>
/**
 *  查找特定类型的subview
 *
 *  @param className 查找的类名
 *
 *  @return 查找结果
 *  @note   广度优先遍历
 */
- (UIView *)findSubviewWithClassNameBFS:(NSString *)className;

#pragma mark ------<查找特定类型的subview - 深度度优先遍历>
/**
 *  查找特定类型的subview
 *
 *  @param className 查找的类名
 *
 *  @return 查找结果
 *  @note   深度度优先遍历
 */
- (UIView *)findSubviewWithClassNameDFS:(NSString *)className;

#pragma mark ------<查找特定类型的Subviews>
/**
 *  查找特定类型的Subviews
 *
 *  @param className 查找的类名
 *
 *  @return 查找结果
 *  @note   深度度优先遍历
 */
- (NSArray *)findSubviewsWithClassNameDFS:(NSString *)className;


@end
