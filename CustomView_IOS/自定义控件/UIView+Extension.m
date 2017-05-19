//
//  UIView+Extension.m
//  JWKit
//
//  Created by 薄睿杰 on 16/6/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic,   copy) dispatch_block_t singleTapEvent;

@property (nonatomic,   copy) dispatch_block_t longTapEvent;

@end

@implementation UIView (Extension)

-(void)setLongTapEvent:(dispatch_block_t)longTapEvent{
    
    objc_setAssociatedObject(self, @selector(longTapEvent), longTapEvent, OBJC_ASSOCIATION_COPY);
    
}

-(dispatch_block_t)longTapEvent{
    
    return objc_getAssociatedObject(self,_cmd);
    
}

-(void)setSingleTapEvent:(dispatch_block_t)singleTapEvent{
    objc_setAssociatedObject(self, @selector(singleTapEvent), singleTapEvent, OBJC_ASSOCIATION_COPY);
}

-(dispatch_block_t)singleTapEvent{
    return objc_getAssociatedObject(self,_cmd);
}

-(void)setViewHidden{
    self.height = 0;
    self.clipsToBounds = true;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

-(UIView *(^)(CGFloat))left{
    
    return ^ UIView*(CGFloat left) {
        CGRect superframe = self.superview.frame;
        CGRect frame = self.frame;
        frame.origin.x = superframe.origin.x + left;
        self.frame = frame;
        return self;
    };
    
}

-(UIView *(^)(CGFloat))right{

    return ^ UIView*(CGFloat right) {
        CGRect superframe = self.superview.frame;
        CGRect frame = self.frame;
        frame.origin.x = superframe.size.width - right - self.width;
        self.frame = frame;
        return self;
    };
}

-(UIView *(^)(CGFloat))top{

    return ^ UIView*(CGFloat top) {
        CGRect superframe = self.superview.frame;
        CGRect frame = self.frame;
        frame.origin.y = superframe.origin.y + top;
        self.frame = frame;
        return self;
    };
}

-(UIView *(^)(CGFloat))bottom{
    
    return ^ UIView*(CGFloat bottom) {
        CGRect superframe = self.superview.frame;
        CGRect frame = self.frame;
        frame.origin.y = superframe.size.height - bottom - self.height;
        self.frame = frame;
        return self;
    };
}

-(UIView *(^)())setCenter{

    return ^ UIView*() {
        CGRect superframe = self.superview.frame;
        CGRect frame = self.frame;
        frame.origin.y = (superframe.size.height - self.height)/2;
        frame.origin.x = (superframe.size.width - self.width)/2;
        self.frame = frame;
        return self;
    };
    
}

-(UIView *(^)(CGSize))setSize{

    return ^ UIView*(CGSize size) {
        CGRect frame = self.frame;
        frame.size = size;
        self.frame = frame;
        return self;
    };
    
}

-(CGRect (^)(UIView *))getRelativewindowFrame{
    
    return ^CGRect (UIView * subView) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGRect relativeframe = [subView convertRect:subView.bounds toView:window];
        return relativeframe;
    };
    
}



-(void)removeAllSubviews{
    NSArray * array = [self subviews];
    for (UIView * sub in array) {
        [sub removeFromSuperview];
    }
}

-(UIViewController *)getController{
    for (UIView * view = [self superview];view ; view = [view superview]) {
        UIResponder * responder = [view nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]||[[responder class] isSubclassOfClass:[UIViewController class]] ) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

- (void)addSingleTapEvent:(void(^)())event{
    
    self.userInteractionEnabled = true;
    
    if (event) {
        self.singleTapEvent = event;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    
    tap.numberOfTapsRequired = 1;
    
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    
    !self.singleTapEvent ? nil:self.singleTapEvent();
    
}

-(void)addlongTapEvent:(void(^)())event{
    
    self.userInteractionEnabled = true;
    
    if (event) {
        self.longTapEvent = event;
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapAction:)];
    longPress.minimumPressDuration = 1; //定义按的时间
    longPress.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:longPress];
    
}

- (void)longTapAction:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        !self.longTapEvent ? nil:self.longTapEvent();
    }else {
        
    }
    
}


- (void)makeDraggable
{
    NSAssert(self.superview, @"Super view is required when make view draggable");
    
    [self makeDraggableInView:self.superview damping:0.4];
}

- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping
{
    if (!view) return;
    [self removeDraggable];
    
    self.zy_playground = view;
    self.zy_damping = damping;
    
    [self zy_creatAnimator];
    [self zy_addPanGesture];
}

- (void)removeDraggable
{
    [self removeGestureRecognizer:self.zy_panGesture];
    self.zy_panGesture = nil;
    self.zy_playground = nil;
    self.zy_animator = nil;
    self.zy_snapBehavior = nil;
    self.zy_attachmentBehavior = nil;
    self.zy_centerPoint = CGPointZero;
}

- (void)updateSnapPoint
{
    self.zy_centerPoint = [self convertPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) toView:self.zy_playground];
    self.zy_snapBehavior = [[UISnapBehavior alloc] initWithItem:self snapToPoint:self.zy_centerPoint];
    self.zy_snapBehavior.damping = self.zy_damping;
}

- (void)zy_creatAnimator
{
    self.zy_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.zy_playground];
    [self updateSnapPoint];
}

- (void)zy_addPanGesture
{
    self.zy_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(zy_panGesture:)];
    [self addGestureRecognizer:self.zy_panGesture];
}

#pragma mark - Gesture

- (void)zy_panGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint panLocation = [pan locationInView:self.zy_playground];
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        UIOffset offset = UIOffsetMake(panLocation.x - self.zy_centerPoint.x, panLocation.y - self.zy_centerPoint.y);
        [self.zy_animator removeAllBehaviors];
        self.zy_attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self
                                                               offsetFromCenter:offset
                                                               attachedToAnchor:panLocation];
        [self.zy_animator addBehavior:self.zy_attachmentBehavior];
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        [self.zy_attachmentBehavior setAnchorPoint:panLocation];
    }
    else if (pan.state == UIGestureRecognizerStateEnded ||
             pan.state == UIGestureRecognizerStateCancelled ||
             pan.state == UIGestureRecognizerStateFailed)
    {
        [self.zy_animator removeAllBehaviors];
        [self.zy_animator addBehavior:self.zy_snapBehavior];
    }
}

#pragma mark - Associated Object

- (void)setZy_playground:(id)object {
    objc_setAssociatedObject(self, @selector(zy_playground), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)zy_playground {
    return objc_getAssociatedObject(self, @selector(zy_playground));
}

- (void)setZy_animator:(id)object {
    objc_setAssociatedObject(self, @selector(zy_animator), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDynamicAnimator *)zy_animator {
    return objc_getAssociatedObject(self, @selector(zy_animator));
}

- (void)setZy_snapBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(zy_snapBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UISnapBehavior *)zy_snapBehavior {
    return objc_getAssociatedObject(self, @selector(zy_snapBehavior));
}

- (void)setZy_attachmentBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(zy_attachmentBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIAttachmentBehavior *)zy_attachmentBehavior {
    return objc_getAssociatedObject(self, @selector(zy_attachmentBehavior));
}

- (void)setZy_panGesture:(id)object {
    objc_setAssociatedObject(self, @selector(zy_panGesture), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIPanGestureRecognizer *)zy_panGesture {
    return objc_getAssociatedObject(self, @selector(zy_panGesture));
}

- (void)setZy_centerPoint:(CGPoint)point {
    objc_setAssociatedObject(self, @selector(zy_centerPoint), [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)zy_centerPoint {
    return [objc_getAssociatedObject(self, @selector(zy_centerPoint)) CGPointValue];
}

- (void)setZy_damping:(CGFloat)damping {
    objc_setAssociatedObject(self, @selector(zy_damping), @(damping), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)zy_damping {
    return [objc_getAssociatedObject(self, @selector(zy_damping)) floatValue];
}


#pragma mark ------<查找特定类型的subview - 广度优先遍历>
/**
 *  查找特定类型的subview
 *
 *  @param className 查找的类名
 *
 *  @return 查找结果
 *  @note   广度优先遍历
 */
- (UIView *)findSubviewWithClassNameBFS:(NSString *)className {
    
    if(self.subviews.count == 0) return nil;
    
    __block UIView *resultView = nil;
    /** 查找自身Subview*/
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([[obj class] isSubclassOfClass:NSClassFromString(className)]) {
            resultView = obj;
            *stop = YES;
        }
    }];
    
    if(!resultView) {
        /** 在自身subview中没有找到，就再下一级的subview中去寻找 */
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            resultView = [obj findSubviewWithClassNameBFS:className];
            if(resultView) {
                *stop = YES;
            }
        }];
    }
    
    return resultView;
}

#pragma mark ------<查找特定类型的subview - 深度度优先遍历>
/**
 *  查找特定类型的subview
 *
 *  @param className 查找的类名
 *
 *  @return 查找结果
 *  @note   深度度优先遍历
 */
- (UIView *)findSubviewWithClassNameDFS:(NSString *)className {
    
    if(self.subviews.count == 0) return nil;
    
    __block UIView *resultView = nil;
    /** 查找自身Subview*/
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([[obj class] isSubclassOfClass:NSClassFromString(className)]) {
            resultView = obj;
            *stop = YES;
        }
        else {
            resultView = [obj findSubviewWithClassNameDFS:className];
            if(resultView) {
                *stop = YES;
            }
        }
    }];
    return resultView;
}

#pragma mark ------<查找特定类型的Subviews>
/**
 *  查找特定类型的Subviews
 *
 *  @param className 查找的类名
 *
 *  @return 查找结果
 *  @note   深度度优先遍历,由于是完全遍历，就不在实现其他遍历方法了
 */
- (NSArray *)findSubviewsWithClassNameDFS:(NSString *)className {
    
    if(self.subviews.count == 0) return [NSMutableArray array];
    
    __block NSMutableArray *resultViews = [NSMutableArray array];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([[obj class] isSubclassOfClass:NSClassFromString(className)]) {
            [resultViews addObject:obj];
        }
        [resultViews addObjectsFromArray:[obj findSubviewsWithClassNameDFS:className]];
    }];
    
    return [resultViews copy];
}


@end
