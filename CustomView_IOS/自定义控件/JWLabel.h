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

@end
