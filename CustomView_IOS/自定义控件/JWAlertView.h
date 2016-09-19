//
//  JWAlertView.h
//  富文本测试
//
//  Created by 梁家文 on 16/3/23.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JWAlertView;

@class JWTextView;

@protocol JWAlertViewDelegate <NSObject>

- (void)JWalertView:(JWAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex clickedButtonAtTitle:(NSString *)buttonTitle; // !< JWAlertViewDelegate

@end


@interface JWAlertView : UIView

@property (nonatomic,strong) UITextView * titleLab;

@property (nonatomic,strong) UITextView * messageLab;

@property (nonatomic,copy) dispatch_block_t dismissAlertTapEvent;

@property (nonatomic, assign) id<JWAlertViewDelegate> delegate;

+ (instancetype)initAlertViewWithMessage:(NSString * )message singleTapEvent:(void(^)(void))event;

//初始化方法
- (instancetype)initJWAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<JWAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;
//显示alert
-(void)alertShow;

//设置title颜色
-(void)setTitleLabColor:(UIColor *)color; 
//设置Message颜色
-(void)setMessageLabColor:(UIColor *)color;
//设置按钮颜色，传入数组的索引。
-(void)setBtnColor:(UIColor *)color atIndex:(NSInteger)index;
//设置加粗按钮索引
-(void)setBtnBoldFountWithIndex:(NSInteger)index;
//设置自动消失时间，可以创建无按钮alert
-(void)setDelayRemoveTimes:(NSInteger)time;

@end


