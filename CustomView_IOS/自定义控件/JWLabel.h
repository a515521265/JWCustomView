//
//  JWLabel.h
//  JWKit
//
//  Created by 薄睿杰 on 16/6/7.
//  Copyright © 2016年 梁家文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWLabel : UILabel

@property (nonatomic,strong) UIColor * labelAnotherColor;

@property (nonatomic,strong) UIFont * labelAnotherFont;

+(JWLabel *)setLabelTitle:(NSString *)title setLabelFrame:(CGRect)frame setLabelColor:(UIColor *)color setLabelFont:(UIFont *)font;


+(JWLabel *)setLabelTitle:(NSString *)title setLabelSize:(CGSize)size setLabelFrameX:(CGFloat)frameOriginX setLabelFrameY:(CGFloat)frameOriginY setLabelColor:(UIColor *)color setLabelFont:(UIFont *)font;

- (void)setNumberAnimationForValueContent:(double)value;

+ (JWLabel *)addLineLabel:(CGRect)frame;

//可以选择复制的lab
// 控制label内容的padding，默认为UIEdgeInsetsZero
@property(nonatomic,assign) UIEdgeInsets contentEdgeInsets;

// 是否需要长按复制的功能，默认为 NO。
// 长按时的背景色通过`highlightedBackgroundColor`设置。
@property(nonatomic,assign) IBInspectable BOOL canPerformCopyAction;

// 如果打开了`canPerformCopyAction`，则长按时背景色将会被改为`highlightedBackgroundColor`
@property(nonatomic,strong) IBInspectable UIColor *highlightedBackgroundColor;


/*↓作者在下面↓*/
/**
 * `QMUILabel`支持通过`contentEdgeInsets`属性来实现类似padding的效果。
 *
 * 同时通过将`canPerformCopyAction`置为`YES`来开启长按复制文本的功能，长按时label的背景色默认为`highlightedBackgroundColor`
 */



@end
