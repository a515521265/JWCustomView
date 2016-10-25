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

- (void)addSingleTapEvent:(void(^)())event;

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


@end
